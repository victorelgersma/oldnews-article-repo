#!/opt/homebrew/bin/bash 

# This folder takes all the files
# in ocr_first_pass which DO NOT
# Exist in ocr_manual_corrections
# and moves them to ocr_manual_corrections.
# What it DOES NOT EVER DO
# Is replace a file that exists in ocr_manual_corrections
# with a file from ocr_first_pass
# it uses rsync to do this


# Define director ies

# STEP 2: We copy the OCR stuff into a separate folder s othat we don't accidentally overwrite the manual corrections
# We correct until we are sure that a simple LLM will understand the text and not distort it when it polishes it off

SOURCE="ocr_first_pass/"
TARGET="ocr_manual_corrections/"

# Ensure the target directory exists
mkdir -p "$TARGET"

echo "Syncing new files from $SOURCE to $TARGET..."

# rsync flags explained:
# -a : archive mode (preserves permissions, timestamps, etc.)
# -v : verbose (so you can see what is being moved)
# --ignore-existing : CRITICAL - does not overwrite files in the target
# --include='*/' --include='*.txt' --exclude='*' : Optional, ensures you only move .txt files
rsync -av --ignore-existing "$SOURCE" "$TARGET"

echo "Sync complete. Only new files were added; no manual corrections were overwritten."