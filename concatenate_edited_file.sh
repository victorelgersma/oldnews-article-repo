# !/opt/homebrew/bin/bash 

## This file will take whatever is under

# ocr_manual_corrections recursively, for example the file path
# ocr_manual_corrections/liverpool_mercury/1845/10/review/* 
# and concatenate all the * together, writing the file 
# to concatenated_manual_corrections/liverpool_mercury/1845/10/review/* 

#!/opt/homebrew/bin/bash

SOURCE_DIR="ocr_manual_corrections"
TARGET_DIR="concatenated_manual_corrections"

# Find all directories that contain at least one regular file
# This avoids processing empty parent directories
find "$SOURCE_DIR" -type f -exec dirname {} + | sort -u | while read -r dir; do

    # Create the corresponding path in the target directory
    # We replace the source root with the target root
    target_path="${dir/$SOURCE_DIR/$TARGET_DIR}"
    
    # Ensure the parent directory exists in the target
    mkdir -p "$(dirname "$target_path")"

    echo "Concatenating files in: $dir -> ${target_path}.txt"

    # Concatenate all files in this specific leaf directory 
    # into a single file named after the leaf directory
    # We use 'cat' on all files (*) in the current source directory
    cat "$dir"/* > "${target_path}.txt"

done

echo "Done. Concatenated files are in $TARGET_DIR."