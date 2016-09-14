#SRCS = cppguide.latex angularjs-google-style.latex google-r-style.latex javaguide.latex jsoncstyleguide.latex pyguide.latex xmlstyle.latex style.latex READMEs.latex best_practices.latex philosophy.latex

SRCS_GUIDE = $(wildcard styleguide/*.html)
OBJS_GUIDE = $(SRCS_GUIDE:.html=.pdf)

SRCS_DOC = $(wildcard styleguide/docguide/*.md)
OBJS_DOC = $(SRCS_DOC:.md=.pdf)

all: build-pdf

fix-sources: styleguide/Rguide.html styleguide/jsoncstyleguide_true.html

styleguide/Rguide.html: styleguide/Rguide.xml
	cp styleguide/Rguide.xml styleguide/Rguide.html

styleguide/jsoncstyleguide_true.html: styleguide/jsoncstyleguide.xml
	cp styleguide/jsoncstyleguide.xml styleguide/jsoncstyleguide_true.html
	cp styleguide/*.png ./


build-pdf: $(OBJS_GUIDE) $(OBJS_DOC) pdf

styleguide/%.latex: styleguide/%.html
	pandoc -s $< -o $@

styleguide/docguide/%.latex: styleguide/docguide/%.md
	pandoc -s $< -o $@

# We need to use xelatex instead of pdflatex for better utf8 support
styleguide/%.pdf: styleguide/%.latex
	xelatex $<

styleguide/docguide/%.pdf: styleguide/docguide/%.latex
	xelatex $<


pdf: pdfs
	mv *.pdf pdfs


pdfs: clean-outputs
	mkdir pdfs


clean: clean-outputs
	rm -fr *.latex
	rm -fr *.pdf
	rm -fr pdfs

clean-outputs:
	rm -fr *.log
	rm -fr *.out
	rm -fr *.aux
	rm -fr *.png
