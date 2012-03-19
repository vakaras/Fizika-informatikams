TEXINPUTS := .:./config:./common:./deps:./content:./examples:
export TEXINPUTS

all: config/main.pdf svg

%.pdf: %.tex
	echo ${TEXINPUTS} ${PATH}
	xelatex -shell-escape -output-directory dist "\input{$*.tex}"
	bibtex dist/main
	xelatex -shell-escape -output-directory dist "\input{$*.tex}"

svg: content/svg/*.svg
	inkscape --file content/svg/fero1.svg --export-pdf=dist/svg-fero1.pdf
	inkscape --file content/svg/fero2.svg --export-pdf=dist/svg-fero2.pdf

show:
	xdg-open dist/main.pdf
