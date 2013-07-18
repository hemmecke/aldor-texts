# Create an article and a beamer version of some text.
# Say 'make article' or 'make beamer' in order to produce
# main.article.pdf and main.beamer.pdf, respectively.
# Simply say 'make' if you want to produce both versions.

# The Name of the main .tex file
MAIN=IntroductionToAldor

# default target
all: beamer article

# clean up
clean:
	-rm core* *.aux *.bbl *.blg *.dvi *.idx *.ilg *.ind *.log *.nav \
		*.out *.pdf *.ps *.snm *.toc *.vrb *~ .*~ \#* \
		main.*.tex

# We have several versions (beamer and article) that differ only in the
# LaTeX wrapper. See main.%.tex below.

# Make a beamer version.
beamer: main.beamer.pdf
main.beamer.tex:
	@echo '\documentclass[ignorenonframetext]{beamer}' > $@
	@echo '\input{${MAIN}}' >> $@

# Make an article version.
article: main.article.pdf
main.article.tex:
	@echo '\documentclass[a4paper]{article}' > $@
	@echo '\usepackage{beamerarticle}' >> $@
	@echo '%\setjobnamebeamerversion{main.beamer}' >> $@
	@echo '\input{${MAIN}}' >> $@

# The output depends on the source.
main.%.pdf: main.%.tex ${MAIN}.tex
	pdflatex $<
