#!/bin/bash

# --- This is a "here document" ---
# It feeds the data below line-by-line into the while loop.
# Each line is read into the variables 'old_name' and 'new_name'.
while read -r old_name new_name; do

  # Announce which pair is being processed
  echo "--- Processing: ${old_name} -> ${new_name} ---"

  # --- Command 1: Rename the .qmd file ---
  # Check if the source file actually exists before trying to move it
  if [ -f "${old_name}.qmd" ]; then
    echo "  1. Renaming file: ${old_name}.qmd -> ${new_name}.qmd"
    mv "${old_name}.qmd" "${new_name}.qmd"
  else
    echo "  1. SKIPPED: File ${old_name}.qmd not found."
  fi

  # --- Command 2: Find and replace text in all relevant files ---
  echo "  2. Replacing text occurrences in *.html, *.qmd, and *.yml files..."
  find . -type f \( -name "*.html" -o -name "*.qmd" -o -name "*.yml" \) -exec sed -i "s/${old_name}/${new_name}/g" {} +

  echo "Done."
  echo "" # Add a blank line for readability

done <<'EOF'
W03_postgis1	W03_HypoTesting
W04_postgis2	W04_LA
W05_quiz	W05_Correlation
W06_RS	W06_Regression
W07_refineries	W07_GLM
W08_ISM	W08_MLReg
W09_blast	W09_DR
W10_ships	W10_Clustering
EOF

echo "All tasks complete."

