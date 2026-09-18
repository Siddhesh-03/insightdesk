#!/bin/bash
declare -A replacements=(
  ["InsightDesk"]="InsightDesk"
  ["insightdesk"]="insightdesk"
  ["Meridian Capital"]="Meridian Capital"
)

EXCLUDES="--exclude-dir=.git --exclude-dir=node_modules --exclude=package-lock.json --exclude=pnpm-lock.yaml --exclude=uv.lock"

for old in "${!replacements[@]}"; do
  new="${replacements[$old]}"
  echo "Replacing: '$old' -> '$new'"
  grep -rIl $EXCLUDES "$old" . | while read -r file; do
    sed -i "s/$old/$new/g" "$file"
    echo "  updated: $file"
  done
done

echo ""
echo "Done. Review before committing:"
echo "  git status"
echo "  git diff"
