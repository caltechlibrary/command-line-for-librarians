#
# Simple Makefile to generated website and presentation slides
#
PRESENTATION_NAME = command-line-for-librarians

build: 
	./mk-website.bash

status:
	git status

release:
	./mk-release.bash

save:
	git commit -am draft
	git push origin master

publish:
	./mk-website.bash
	./mk-release.bash
	./publish.bash

clean:
	if [ -f 00-$(PRESENTATION_NAME) ]; then /bin/rm ??-$(PRESENTATION_NAME); fi
	if [ -f index.html ]; then /bin/rm index.html; fi
	if [ -f abstract.html ]; then /bin/rm abstract.html; fi
	if [ -f install.html ]; then /bin/rm install.html; fi
	if [ -f outline.html ]; then /bin/rm outline.html; fi
	if [ -f $(PRESENTATION_NAME)-slides.zip ]; then /bin/rm $(PRESENTATION_NAME)-slides.zip; fi

#test:
