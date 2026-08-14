# ---- build stage ----
FROM debian:bookworm-slim AS build

ARG FLUTTER_VERSION=3.41.2
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# 빌드 시 주입받을 변수 선언 (외부에서 --build-arg로 전달받음)
ARG CLIENT_ID
ARG REDIRECT_URI
ARG ROUTE_URI
ARG BACKEND_URI

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

# --dart-define을 통해 Flutter 앱 내부로 변수 주입
RUN flutter build web --release --target lib/main.dart \
    --dart-define=CLIENT_ID=${CLIENT_ID} \
    --dart-define=REDIRECT_URI=${REDIRECT_URI} \
    --dart-define=ROUTE_URI=${ROUTE_URI} \
    --dart-define=BACKEND_URI=${BACKEND_URI}

# ---- runtime stage ----
FROM nginx:1.25-alpine AS runtime

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 1104

CMD ["nginx", "-g", "daemon off;"]
