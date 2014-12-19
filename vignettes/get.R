fnames = strsplit("Data-exercises.html ggplot2.html Ranges-exercises.html vectors-exercises.html index.html Data-exercises.R ggplot2.R Ranges-exercises.R RIntroSlides.R Bioconductor-slides.R vectors-exercises.R Data-exercises.pdf ggplot2.pdf Ranges-exercises.pdf RIntroSlides.pdf Bioconductor-slides.pdf vectors-exercises.pdf index.pdf BRFSS-subset.csv"," ")[[1]]
sapply(fnames,function(x) {
  download.file(file.path("http://watson.nci.nih.gov/~sdavis/tutorials/IntroToR",x),destfile=x)
})