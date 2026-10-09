#!/usr/bin/env bash
# upload-build.sh — upload the latest macOS DMG and ship it to R2
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUCKET="remotetap-downloads"
DMG_NAME="RemoteTap.dmg"
DMG_PATH="${1:-$HOME/Projects/study/MediaRemote/build/macos/$DMG_NAME}"

# ── 1. Verify DMG exists ────────────────────────────────────────────────────
if [[ ! -f "$DMG_PATH" ]]; then
  echo "Error: DMG not found at $DMG_PATH"
  echo "Usage: $0 [path/to/RemoteTap.dmg]"
  exit 1
fi
echo "→ DMG: $DMG_PATH ($(du -sh "$DMG_PATH" | cut -f1))"

# ── 2. Upload to Cloudflare R2 ──────────────────────────────────────────────
echo "→ Uploading to R2 ($BUCKET/$DMG_NAME)..."
wrangler r2 object put "$BUCKET/$DMG_NAME" --file "$DMG_PATH" --remote

# ── 3. Update SHA-256 in index.html ──────────────────────────────────────────
SHA=$(shasum -a 256 "$DMG_PATH" | awk '{print $1}')
echo "→ SHA-256: $SHA"
sed -i '' "s|<code id=\"sha-code\">[^<]*</code>|<code id=\"sha-code\">$SHA</code>|" "$SCRIPT_DIR/index.html"

# ── 4. Commit and push ──────────────────────────────────────────────────────
cd "$SCRIPT_DIR"
if ! git diff --quiet index.html; then
  echo "→ Committing updated checksum..."
  git add index.html
  git commit -m "Update macOS DMG build checksum (${SHA:0:12})"
  git push
  echo "✓ Site updated and deployed"
else
  echo "✓ Checksum unchanged — no commit needed"
fi

echo "✓ Done — https://downloads.remotetap.app/$DMG_NAME"
