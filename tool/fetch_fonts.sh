#!/usr/bin/env bash
# Downloads Clash Display (weights 500–700) from Fontshare into assets/fonts.
#
# Clash Display is under the ITF Free Font License, which doesn't allow the font
# files to be redistributed through a repository, so they aren't committed here.
# Each developer gets their own copy directly from Fontshare, as the licence
# requires. DM Sans (SIL OFL) is committed normally.
set -euo pipefail

cd "$(dirname "$0")/../assets/fonts"
css=$(curl -fsSL "https://api.fontshare.com/v2/css?f[]=clash-display@500,600,700&display=swap")

python3 - "$css" <<'PY'
import re, sys, urllib.request
css = sys.argv[1]
found = 0
for block in re.findall(r'@font-face\s*{(.*?)}', css, re.S):
    family = re.search(r"font-family:\s*'([^']+)'", block).group(1)
    if family != 'Clash Display':
        continue  # Fontshare's CSS can include other families
    weight = re.search(r'font-weight:\s*(\d+)', block).group(1)
    url = 'https:' + re.search(r"url\('(//[^']+\.ttf)'\)", block).group(1)
    name = f'ClashDisplay-{weight}.ttf'
    urllib.request.urlretrieve(url, name)
    print(f'downloaded {name}')
    found += 1
if found != 3:
    sys.exit(f'expected 3 Clash Display weights, got {found}')
PY
