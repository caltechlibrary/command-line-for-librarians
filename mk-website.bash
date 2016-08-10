#!/bin/bash
#

function makePage () {
    page=$1
    nav=$2
    html_page=$3
    echo "Generating $html_page"
    mkpage \
        "content=$page" \
        "nav=$nav" \
        page.tmpl > $html_page
}


# Presentation slides
md2slides -css css/slides.css -template slide.tmpl presentation.md 

# index.html
makePage README.md nav.md index.html

# abstract.html
makePage abstract.md nav.md abstract.html 

# install.html (slide presentation)
makePage INSTALL.md nav.md install.html


