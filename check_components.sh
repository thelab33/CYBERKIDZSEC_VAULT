#!/bin/bash

TEMPLATE="templates/index.html"
COMPONENT_DIR="templates/components"

echo " Checking {% include %} references in $TEMPLATE"

# Extract all {% include "components/..." %} lines
INCLUDES=$(grep -oP '{%\s*include\s+"components/[^"]+\.html"\s*%}' "$TEMPLATE" | \
  sed -E 's/{%\s*include\s+"(components\/[^"]+\.html)".*/\1/')

EXIT_CODE=0

for file in $INCLUDES; do
  full_path="$file"
  if [ ! -f "$full_path" ]; then
    echo " MISSING: $full_path"
    EXIT_CODE=1
  elif [ ! -s "$full_path" ]; then
    echo "  EMPTY:   $full_path"
    EXIT_CODE=2
  else
    echo " OK:      $full_path"
  fi
done

echo
if [ "$EXIT_CODE" -eq 0 ]; then
  echo " All includes are present and non-empty!"
else
  echo "  One or more includes are missing or empty. Fix before render."
fi

exit $EXIT_CODE
