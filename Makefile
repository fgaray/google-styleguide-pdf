#SRCS = cppguide.latex angularjs-google-style.latex google-r-style.latex javaguide.latex jsoncstyleguide.latex pyguide.latex xmlstyle.latex style.latex READMEs.latex best_practices.latex philosophy.latex

SRCS_GUIDE = $(wildcard styleguide/*.html)
SRCS_GUIDE := $(filter-out styleguide/google-r-style.html, $(SRCS_GUIDE))
SRCS_GUIDE := $(filter-out styleguide/jsoncstyleguide.html, $(SRCS_GUIDE))
OBJS_GUIDE = $(SRCS_GUIDE:.html=.pdf)

SRCS_DOC = $(wildcard styleguide/docguide/*.md)
OBJS_DOC = $(SRCS_DOC:.md=.pdf)

all: build-pdf



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
