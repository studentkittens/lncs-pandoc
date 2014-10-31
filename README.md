lncs-pandoc
===========

a slightly modified pandoc latex version to be conform with lncs

Copy llncs.latex to $HOME/.pandoc/templates/. 

~~~sh
$ pandoc --biblio paper.bib --csl ieee.csl -N -o paper.tex --template=llncs paper.md 
$ latexmk -pdf paper.tex && latexmk -c 
$ zathura paper.pdf
~~~
