all: html pdf Rcode upload

HTML = Data-exercises.html ggplot2.html Ranges-exercises.html vectors-exercises.html index.html

PDF = Data-exercises.pdf ggplot2.pdf Ranges-exercises.pdf RIntroSlides.pdf Bioconductor-slides.pdf vectors-exercises.pdf index.pdf DESeq2_parathyroid.pdf

RCODE = Data-exercises.R ggplot2.R Ranges-exercises.R RIntroSlides.R Bioconductor-slides.R vectors-exercises.R DESeq2_parathyroid.R

ORIG = Data-exercises.Rmd ggplot2.Rmd Ranges-exercises.Rnw RIntroSlides.Rnw Bioconductor-slides.Rnw vectors-exercises.Rmd DESeq2_parathyroid.Rnw

html: $(HTML)
pdf:  $(PDF)
Rcode:$(RCODE)

DESeq2_parathyroid.pdf: DESeq2_parathyroid.Rnw
	Rscript -e "library(knitr); knit('DESeq2_parathyroid.Rnw'); system('pdflatex DESeq2_parathyroid'); relocateAnswers(); for(i in 1:2) system('pdflatex DESeq2_parathyroid')"

DESeq2_parathyroid.R: DESeq2_parathyroid.Rnw
	Rscript -e "library(knitr); purl('DESeq2_parathyroid.Rnw',documentation=1)"

%.R: %.Rmd
	Rscript -e "library(knitr); purl('$<')"

%.R: %.Rnw
	Rscript -e "library(knitr); purl('$<')"

%.pdf: %.Rmd
	Rscript -e "library(rmarkdown); rmarkdown::render('$<',BiocStyle::pdf_document())"

%.html: %.Rmd
	Rscript -e "library(rmarkdown); rmarkdown::render('$<',BiocStyle::html_document())"

%.pdf: %.Rnw
	Rscript -e "library(knitr); knit2pdf('$<')"

%.html: %.tex
	pandoc -t html -f latex -o $@ $<

%.tex: %.Rnw
	Rscript -e "library(knitr); knit('$<')"

upload: html pdf Rcode
	rsync $(ORIG) $(HTML) $(RCODE) $(PDF) BRFSS-subset.csv get.R rgale:public_html/tutorials/IntroToR/
