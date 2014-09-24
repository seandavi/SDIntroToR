SDIntroToR
==========

This package contains a set of instructional material to introduce R in a guided interactive way.  A beamer slide presentation with examples meant to be worked by students is included.

Installation
============

1. Start R (or RStudio)
2. Paste the following code into your R session

```
install.packages('devtools')
devtools::install_github('seandavi/SDIntroToR')
```

Where are the slides?
=====================
After installing the package, the slides are available by typing:

```
vignette('RIntroSlides','SDIntroToR')
```

