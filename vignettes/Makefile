all: html pdf R

html: Exercises.html ggplot2.html Ranges-exercises.html vectors-exercises.html index.html

pdf: Exercises.pdf ggplot2.pdf Ranges-exercises.pdf RIntroSlides.pdf Bioconductor-slides.pdf vectors-exercises.pdf index.pdf

R: Exercises.R ggplot2.R Ranges-exercises.R RIntroSlides.R Bioconductor-slides.R vectors-exercises.R index.R

%.R: %.Rmd
	Rscript -e "library(knitr); purl('$<')"

%.R: %.Rnw
	Rscript -e "library(knitr); purl('$<')"

%.pdf: %.Rmd
	Rscript -e "library(rmarkdown); rmarkdown::render('$<',BiocStyle::pdf_document())"

%.html: %.Rmd
	Rscript -e "library(rmarkdown); rmarkdown::render('$<',BiocStyle::html_document())"

%.pdf: %.Rnw
	Rscript -e "library(knitr); knit('$<')"

%.html: %.tex
	pandoc -t html -f latex -o $@ $<

%.tex: %.Rnw
	Rscript -e "library(knitr); knit('$<')"

