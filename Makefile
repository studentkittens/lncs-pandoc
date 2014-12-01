all: pandoc
	rm -f paper.pdf
	@latexmk -pdf paper.tex

pandoc:
	pandoc --biblio paper.bib --csl ieee.csl -N -o paper.tex --template=llncs paper.md

install:
	mkdir -p ~/.pandoc/templates
	cp llncs.latex ~/.pandoc/templates

view: all
	mupdf paper.pdf

clean:
	rm -f paper.tex
	latexmk -c paper.tex
