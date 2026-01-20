#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT=$(cd "$(dirname "$0")/.." && pwd)
SVG_EXPORT_SCRIPT="scripts/render_icons.cjs"
IOS_PROJECT_NAME="${IOS_PROJECT_NAME:-juke}"
ANDROID_PROJECT_NAME="${ANDROID_PROJECT_NAME:-juke}"
IOS_EXPORT_JSON="mobile/ios/${IOS_PROJECT_NAME}/juke-iOS/BrandAssets/icon_export.json"
ANDROID_EXPORT_JSON="mobile/android/${ANDROID_PROJECT_NAME}/brand_assets/icon_export.json"

if [[ ! -f "$PROJECT_ROOT/$SVG_EXPORT_SCRIPT" ]];
then
  echo "Missing renderer script: $SVG_EXPORT_SCRIPT" >&2
  exit 1
fi

run_render() {
  docker compose run --rm \
    -v "$PROJECT_ROOT":/workspace \
    web \
    sh -c "set -e; npm install --prefix /tmp/icon-gen sharp@0.33.2 >/tmp/icon-gen.log 2>&1; cd /workspace; NODE_PATH=/tmp/icon-gen/node_modules node $SVG_EXPORT_SCRIPT $IOS_EXPORT_JSON $ANDROID_EXPORT_JSON"
}

run_render

echo "Icon exports complete. Files written under mobile/ios/${IOS_PROJECT_NAME}/juke-iOS/BrandAssets and mobile/android/${ANDROID_PROJECT_NAME}/brand_assets."