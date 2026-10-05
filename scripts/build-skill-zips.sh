#!/usr/bin/env bash
# Build one zip per skill into dist/.
# Each zip holds the skill's folder (e.g. plan-prd/SKILL.md), the layout
# Claude's Settings > Customize > Skills upload expects. Needs only python3.
set -euo pipefail
cd "$(dirname "$0")/.."
rm -rf dist && mkdir -p dist
cd skills
for d in */; do
  name="${d%/}"
  [ -f "$name/SKILL.md" ] || continue
  python3 -m zipfile -c "../dist/$name.zip" "$name"
done
cd ..
ls -1 dist
