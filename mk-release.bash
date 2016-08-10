#!/bin/bash
RELEASE_NAME=archivesspace-api-workshop
zip -r $RELEASE_NAME-slides.zip README.md LICENSE
findfile -s .css | while read FNAME; do
    zip -r $RELEASE_NAME-slides.zip $FNAME
done
findfile -s .html | while read FNAME; do
    zip -r $RELEASE_NAME-slides.zip $FNAME
done
findfile -s .py | while read FNAME; do
    zip -r $RELEASE_NAME-slides.zip $FNAME
done
findfile -s .json | while read FNAME; do
    zip -r $RELEASE_NAME-slides.zip $FNAME
done
