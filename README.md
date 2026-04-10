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

0. start by adding the metadata to the other repo and check that the file appears on the homepage
1. Make sure the article you want to digitize has a corresponding journal name under 'img'
i.e 

```sh
$ mkdir -p examiner/1840/03/election_news
```
2. use `tesseract_ocr.sh` to populate the file in `ocr_first_pass`:

example:

```sh
$ ./tesseract_ocr.sh img/waterford_chronicle/1846/05/review-vestiges/
```

3. use `populate_manual_corrections_folder.sh` to create an identical copy in the `ocr_manual_corrections` folder

```sh
./populate_manual_corrections_folder.sh
```

4. perform manual corrections on the file in the `ocr_manual_corrections` folder

(we recommend you only do this if you find that the LLM generated stuff is unreadable. Once the correctionsare done you can then re-run steps 5-X).

5. use `concatenate_edited_file.sh` to produce a single file in `concatenated_manual_corrections`
6. use LLM software (and `instructions.txt`) to polish the file, putting the output under `concatenanted_manual_corrections` replacing the extension .txt --> .polished.md
7. run `generate_html.sh` to convert the cleaned markdown file under `concatenated_manual_corrections` to an html file under `html_polished`
8. Deploy the changes with `./deploy.sh`

## Notes on Pandoc Usage

We do not use the `-s` flag because in the final product, the article becomes a php partial that is incorporated into a larger `layout.php` file within the wider `oldnews` site. 