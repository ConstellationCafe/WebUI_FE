#!/usr/bin/env bash
# 기능별 API 테스트와 위젯 테스트가 모두 있는지 검사한다.
#
# - API 테스트: 이름이 *_api_test.dart 또는 *_api_contract_test.dart인 파일
# - 위젯 테스트: testWidgets( 를 포함한 *_test.dart 파일
#
# 새 기능 폴더를 추가하면 아래 FEATURES에 등록하고 test/ 아래 같은 경로에
# 두 종류의 테스트를 추가해야 한다. 등록하지 않은 기능 폴더도 실패로 본다.
set -euo pipefail

cd "$(dirname "$0")/.."

# "lib 기준 경로|필요한 테스트 종류"
FEATURES=(
  "core|api widget"
  "shared|api widget"
  "feature/auth|api widget"
  "feature/guild_select|api widget"
  "feature/home|widget"
  "feature/notification|api widget"
  "feature/profile|api widget"
  "feature/modules/academy|api widget"
  "feature/modules/chatbot|api widget"
  "feature/modules/shadowverse|api widget"
  "feature/modules/erp/point|api widget"
  "feature/modules/erp/penalty|api widget"
)

# 기능이 아니라 다른 기능을 묶는 폴더
CONTAINERS=(
  "feature/modules"
  "feature/modules/erp"
  "feature/modules/erp/category"
)

failed=0

error() {
  echo "::error::$1"
  failed=1
}

contains() {
  local needle=$1
  shift
  local item
  for item in "$@"; do
    [[ "$item" == "$needle" ]] && return 0
  done
  return 1
}

declared=()
for entry in "${FEATURES[@]}"; do
  declared+=("${entry%%|*}")
done

# 등록되지 않은 기능 폴더 찾기
for dir in lib/feature/*/ lib/feature/modules/*/ lib/feature/modules/erp/*/; do
  path=${dir#lib/}
  path=${path%/}
  if ! contains "$path" "${declared[@]}" && ! contains "$path" "${CONTAINERS[@]}"; then
    error "lib/$path 기능이 tool/check_feature_tests.sh에 등록되지 않았습니다."
  fi
done

# test/ 바로 아래에는 테스트를 두지 않는다
for file in test/*_test.dart; do
  [[ -e "$file" ]] || continue
  error "$file 은(는) 기능 폴더(test/feature/...) 아래로 옮겨야 합니다."
done

for entry in "${FEATURES[@]}"; do
  path=${entry%%|*}
  kinds=${entry#*|}
  test_dir="test/$path"

  if [[ ! -d "$test_dir" ]]; then
    error "$test_dir 폴더가 없습니다."
    continue
  fi

  for kind in $kinds; do
    case $kind in
      api)
        found=$(find "$test_dir" -name '*_api_test.dart' \
          -o -name '*_api_contract_test.dart' | head -n 1)
        ;;
      widget)
        found=$(grep -rl --include='*_test.dart' 'testWidgets(' "$test_dir" \
          | head -n 1 || true)
        ;;
    esac
    if [[ -z "$found" ]]; then
      error "$test_dir 에 $kind 테스트가 없습니다."
    else
      echo "ok  $test_dir ($kind: $found)"
    fi
  done
done

exit $failed
