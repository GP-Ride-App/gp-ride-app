#!/usr/bin/env bash
# Interactive Apple credential setup + production iOS builds for GP Ride.
# Run this in your own Terminal (not CI) — Apple login requires prompts / 2FA.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EAS=(npx eas-cli@latest)

echo "==> Logged in EAS account:"
"${EAS[@]}" whoami

setup_ios() {
  local app_dir="$1"
  local label="$2"
  echo ""
  echo "========================================"
  echo "  $label — Apple credentials + iOS production build"
  echo "  dir: $app_dir"
  echo "========================================"
  cd "$app_dir"

  echo ""
  echo "Opening credentials manager. Choose:"
  echo "  1) Set up a new Apple Distribution Certificate (let EAS manage)"
  echo "  2) Set up App Store provisioning profile for production"
  echo "  Log in with the Apple Developer account that owns com.gpride.*"
  echo ""
  "${EAS[@]}" credentials -p ios

  echo ""
  echo "Starting production iOS build (App Store distribution)..."
  "${EAS[@]}" build --platform ios --profile production
}

setup_ios "$ROOT/gp-ride-mobile" "Passenger (com.gpride.mobile)"
setup_ios "$ROOT/gp-ride-driver-mobile" "Driver (com.gpride.driver)"

echo ""
echo "When builds finish, submit with:"
echo "  cd gp-ride-mobile && npx eas-cli@latest submit --platform ios --latest --profile production"
echo "  cd gp-ride-driver-mobile && npx eas-cli@latest submit --platform ios --latest --profile production"
echo ""
echo "Android AABs are already building on EAS (production). Submit when green:"
echo "  npx eas-cli@latest submit --platform android --latest --profile production"
echo "(Requires Google Play Console service account JSON linked in EAS.)"
