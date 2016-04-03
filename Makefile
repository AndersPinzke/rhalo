# Makefile to produce the article.
PDFLATEX  =  TEXINPUTS=.//: BSTINPUTS=.//: pdflatex
LATEX  =  TEXINPUTS=.//: BSTINPUTS=.//: latex
DVIPS  =  dvips
FIGURES = 

.PRECIOUS: $(FIGURES)

default: paper.ps

%.pdf :  $(FIGURES) %.tex
	$(PDFLATEX) $*.tex
	TEXINPUTS=:.// BSTINPUTS=:.// bibtex $*
	$(PDFLATEX) $*.tex
	$(PDFLATEX) $*.tex
	$(PDFLATEX) $*.tex
	make clean

%.ps :  $(FIGURES) %.tex
	$(LATEX) $*.tex
	TEXINPUTS=:.// BSTINPUTS=:.// bibtex $*
	$(LATEX) $*.tex
	$(LATEX) $*.tex
	$(LATEX) $*.tex
	$(DVIPS) -o $*.ps $*.dvi
	ps2pdf $*.ps
	make clean

figures/%.eps: figures/%_raw.eps figures/%.tex
	(cd figures; latex $*.tex; \
	dvips -E -o $*.eps $*.dvi; \
	perl -ane '{ s/%%BoundingBox: [-0-9]+/%%BoundingBox: 135/g; print}' $*.eps > tmp.eps; \
	mv tmp.eps $*.eps; \
	rm -f *.dvi *.log *.aux)

clean:
	rm -f *.log *.toc *.aux *.dvi *.bak *.bbl *.blg *.obj *.out

realclean:
	rm -f *.log *.toc *.aux *.dvi *.obj *.bak *.bbl *.blg *.brf \
              *.pdf *.ps */*.ps *~ */*~ *.bak */*.bak 








