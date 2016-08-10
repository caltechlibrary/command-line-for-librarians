#!/bin/bash
RELEASE_NAME="command-line-for-librarians"
zip -r $RELEASE_NAME-slides.zip README.md LICENSE
find . -type f | grep -E '.css$' | while read FNAME; do
    zip -r $RELEASE_NAME-slides.zip $FNAME
done
find . -type f | grep -E '.html$' | while read FNAME; do
    zip -r $RELEASE_NAME-slides.zip $FNAME
done
find . -type f | grep -E '.json$' | while read FNAME; do
    zip -r $RELEASE_NAME-slides.zip $FNAME
done
find . -type f | grep -E '.md$' | while read FNAME; do
    zip -r $RELEASE_NAME-slides.zip $FNAME
done
