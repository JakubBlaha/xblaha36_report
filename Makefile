# makefile for compilation
CO=PPFIT-llmpipeline-formalism
FORM_DIR=formalism/tex-new
FORM=doc

all: $(CO).pdf

# Build the report. Depends on the embedded formalism PDF being in place first.
$(CO).pdf: pdf/doc.pdf
	pdflatex $(CO)
	bibtex $(CO)
	pdflatex $(CO)
	pdflatex $(CO)

# Copy the freshly built formalism PDF into pdf/doc.pdf (included by the report).
pdf/doc.pdf: formalism
	mkdir -p pdf
	cp $(FORM_DIR)/$(FORM).pdf pdf/doc.pdf

# Build the formalism document in the submodule.
.PHONY: formalism
formalism:
	cd $(FORM_DIR) && latexmk -pdf $(FORM).tex

clean:
	rm -f *.dvi *.log $(CO).blg $(CO).bbl $(CO).toc *.aux $(CO).out $(CO).lof $(CO).ptc
	rm -f $(CO).pdf
	rm -f *~

# Also clean the formalism build artifacts.
.PHONY: clean-formalism
clean-formalism:
	cd $(FORM_DIR) && latexmk -C $(FORM).tex

pack:
	tar czvf $(CO).tar.gz *.tex *.bib *.bst ./images/* $(CO).pdf Makefile formalism/tex-new/doc.tex formalism/tex-new/formalism.tex pdf/doc.pdf

vlna:
	vlna -l *.tex

# Spocita normostrany / Count of standard pages
normostrany:
	echo "scale=2; `detex -n *.tex | wc -c`/1800;" | bc
