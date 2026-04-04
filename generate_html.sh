# !/opt/homebrew/bin/bash 

# This file takes everything under 'concatenated_manual_corrections' which
# has the word .polished. in i
# and uses pandoc to convert it to html, outputting the result to 
# html_polished
# For example: concatenanted_manual_corrections/liverpool_mercury/1845/10/readership.polished.md
# will be outputted to html_polished/liverpool_mercury/1845/10/readership.html


#!/opt/homebrew/bin/bash

SOURCE_DIR="concatenated_manual_corrections"
TARGET_DIR="html_polished"

# Ensure the target root exists
mkdir -p "$TARGET_DIR"

# Find all files containing ".polished." in their name
# Using -iname for case-insensitivity just in case
find "$SOURCE_DIR" -type f -name "*.polished.*" | while read -r input_file; do

    # 1. Swap the root directory name
    # Result: html_polished/liverpool_mercury/1845/10/readership.polished.md
    target_path_full="${input_file/$SOURCE_DIR/$TARGET_DIR}"

    # 2. Create the target subdirectory structure
    output_dir=$(dirname "$target_path_full")
    mkdir -p "$output_dir"

    # 3. Define the final HTML filename
    # We strip the extensions (.polished.md) and add .html
    # This logic assumes the files end in .md; 
    # if they vary, we can use ${target_path_full%.*.*}.html
    output_file="${target_path_full%.polished.*}.html"

    echo "Converting: $input_file -> $output_file"

    # 4. Run Pandoc
    # --standalone (or -s) produces a proper HTML file with a <head> and <body>
    pandoc -s "$input_file" -o "$output_file"

done

echo "HTML conversion complete."