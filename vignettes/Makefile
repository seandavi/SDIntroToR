all: html pdf

html: Exercises.html ggplot2.html Ranges-exercises.html

pdf: Exercises.pdf ggplot2.pdf Ranges-exercises.pdf RIntroSlides.pdf Bioconductor-slides.pdf

%.pdf: %.Rmd
	Rscript -e "library(rmarkdown); rmarkdown::render('$<',BiocStyle::pdf_document())"

%.html: %.Rmd
	Rscript -e "library(rmarkdown); rmarkdown::render('$<',knitrBootstrap::html_document())"

%.pdf: %.Rnw
	Rscript -e "library(knitr); knit('$<')"

%.html: %.tex
	pandoc -t html -f latex -o $@ $<

%.tex: %.Rnw
	Rscript -e "library(knitr); knit('$<')"

