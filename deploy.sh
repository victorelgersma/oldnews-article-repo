#!/opt/homebrew/bin/bash 
# This script does two things - it deploys the first step of the pipeline and the final step of the pipeline
# The first step are the original pictures. This is important because if people have any doubts about the accuracy of the transcription we can show them the pictures
# The second step is the actual articles. It makes sense to keep the article html in a separate repo
# to the repo hosting oldnews.vjbe.net, because these articles are the natural end product of my digital humanities pipeline. 

## Step 1: Deploy images
deploy img oldnews-photos

## Step 2: Deploy polished html

deploy html_polished oldnews-articles-only