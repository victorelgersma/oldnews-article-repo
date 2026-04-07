#!/opt/homebrew/bin/bash 

# Bash 5 only

# STEP 1: We must use tesseract to OCR the pictures in the img/ folder

input_path="$1"

if [ -d "$input_path" ]; then
    # Using a nullglob so the loop doesn't run if no .png files exist
    shopt -s nullglob
    
    for input_file in "$input_path"/*.png; do
        # ${variable/#search/replace} anchors to the START of the string
        output_path_full="${input_file/#img/ocr_first_pass}"
        
        output_dir=$(dirname "$output_path_full")
        mkdir -p "$output_dir"

        # % handles the end of the string (stripping the extension)
        output_base="${output_path_full%.png}"

        # NEW: Replace all spaces with underscores in the output filename
        # ${variable//search/replace} replaces ALL occurrences
        output_base="${output_base// /_}"

        echo "Processing: $input_file -> ${output_base}.txt"
        tesseract --oem 1 --psm 4 "$input_file" "$output_base"
    done
else
    echo "Error: Directory '$input_path' not found."
    exit 1
fi