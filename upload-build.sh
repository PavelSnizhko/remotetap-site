#!/usr/bin/env bash
# upload-build.sh — package the latest Xcode archive and ship it to R2
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUCKET="remotetap-downloads"
ZIP_NAME="RemoteTap-debug.zip"

# ── 1. Find latest xcarchive ─────────────────────────────────────────────────
echo "→ Finding latest Xcode archive..."
ARCHIVE=$(ls -td ~/Library/Developer/Xcode/Archives/*/*.xcarchive 2>/dev/null | head -1)
if [[ -z "$ARCHIVE" ]]; then
  echo "Error: no .xcarchive found in ~/Library/Developer/Xcode/Archives/"
  exit 1
fi
echo "  $(basename "$ARCHIVE")"

APP=$(ls -d "$ARCHIVE/Products/Applications/"*.app 2>/dev/null | head -1)
if [[ -z "$APP" ]]; then
  echo "Error: no .app found in archive"
  exit 1
fi
echo "  App: $(basename "$APP")"

# ── 2. Package as zip ────────────────────────────────────────────────────────
echo "→ Packaging..."
TMP_ZIP="$(mktemp -t remotetap-build).zip"
ditto -c -k --sequesterRsrc --keepParent "$APP" "$TMP_ZIP"
echo "  Size: $(du -sh "$TMP_ZIP" | cut -f1)"

# ── 3. Upload to Cloudflare R2 ───────────────────────────────────────────────
echo "→ Uploading to R2 ($BUCKET/$ZIP_NAME)..."
wrangler r2 object put "$BUCKET/$ZIP_NAME" --file "$TMP_ZIP" --remote

# ── 4. Update SHA-256 in index.html ─────────────────────────────────────────
SHA=$(shasum -a 256 "$TMP_ZIP" | awk '{print $1}')
echo "→ SHA-256: $SHA"
sed -i '' "s|<code id=\"sha-code\">[^<]*</code>|<code id=\"sha-code\">$SHA</code>|" "$SCRIPT_DIR/index.html"

# ── 5. Commit and push ───────────────────────────────────────────────────────
cd "$SCRIPT_DIR"
if ! git diff --quiet index.html; then
  echo "→ Committing updated checksum..."
  git add index.html
  git commit -m "Update debug build checksum (${SHA:0:12})"
  git push
  echo "✓ Site updated and deployed"
else
  echo "✓ Checksum unchanged — no commit needed"
fi

rm -f "$TMP_ZIP"
echo "✓ Done — https://downloads.remotetap.app/$ZIP_NAME"
