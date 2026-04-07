# Dependencies

- Bash 5
- Tesseract

Running the following command should do the trick
```
brew install bash
brew install tesseract
```

If you don't have homebrew installed, follow the instructions here: https://brew.sh/

# Workflow

1. use `tesseract_ocr.sh` to populate the file in `ocr_first_pass`
2. use `populate_manual_corrections_folder.sh` to create an identical copy in the `ocr_manual_corrections` folder
3. perform manual corrections on the file in the `ocr_manual_corrections` folder

4. use `concatenate_edited_file.sh` to produce a single file in `concatenated_manual_corrections`
5. use LLM software (and `instructions.txt`) to polish the file, putting the output under `concatenanted_manual_corrections` replacing the extension .txt --> .polished.md
6. run `generate_html.sh` to convert the cleaned markdown file under `concatenated_manual_corrections` to an html file under `html_polished`
7. Deploy the changes with `./deploy.sh`

## Notes on Pandoc Usage

We do not use the `-s` flag because in the final product, the article becomes a php partial that is incorporated into a larger `layout.php` file within the wider `oldnews` site. 