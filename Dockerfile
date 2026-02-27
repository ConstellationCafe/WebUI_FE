# ---- build stage ----
FROM debian:bookworm-slim AS build

ARG FLUTTER_VERSION=3.41.2
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl git unzip xz-utils zip \
 && rm -rf /var/lib/apt/lists/*

# Install Flutter SDK
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME} \
 && flutter --version

WORKDIR /app

# Copy pubspec first for better layer caching
COPY pubspec.yaml pubspec.lock* ./
RUN flutter config --enable-web \
 && flutter pub get

# Copy the rest
COPY . .

# Build Flutter Web (entrypoint: lib/main.dart)
RUN flutter build web --release --target lib/main.dart

# ---- runtime stage ----
FROM nginx:1.25-alpine AS runtime

# Nginx listens on 1104
RUN sed -i 's/listen       80;/listen       1104;/' /etc/nginx/conf.d/default.conf

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 1104

CMD ["nginx", "-g", "daemon off;"]