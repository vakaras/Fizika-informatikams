TEXINPUTS := .:./config:./common:./deps:./content:./examples:
export TEXINPUTS

.SUFFIXES: .svg .pdf

all: images config/main.pdf

OUTPUT_DIR=dist
SVG_DIR=content/svg
SVG_FILES_NAMES=\
	fero1.svg \
	fero2-2.svg \
	fero2.svg \
	fero3.svg \
	fero4.svg \
	fero5.svg \
	fero6.svg \
	fero7.svg \
	fero8.svg \
	volamperine.svg \

SVG_FILES=$(shell \
					for file_name in ${SVG_FILES_NAMES}; do \
						echo "${SVG_DIR}/$${file_name}"; \
					done \
					)
#PDF_FILES=$(shell \
					#for file_name in ${SVG_FILES_NAMES:.svg=.pdf}; do \
						#echo "${OUTPUT_DIR}/svg-$${file_name}"; \
					#done \
					#)
PDF_FILES=${SVG_FILES:.svg=.pdf}

images: $(PDF_FILES)

# FIXME: Viskas turi būti kompiliuojama dist kataloge!
.svg.pdf :
	inkscape --file $< --export-pdf=$@

%.pdf: %.tex
	echo ${TEXINPUTS} ${PATH}
	xelatex -shell-escape -output-directory dist "\input{$*.tex}"
	bibtex dist/main
	xelatex -shell-escape -output-directory dist "\input{$*.tex}"

show:
	xdg-open dist/main.pdf
