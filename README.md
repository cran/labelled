[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active) 
[![Travis-CI Build Status](https://travis-ci.org/larmarange/labelled.svg?branch=master)](https://travis-ci.org/larmarange/labelled)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/labelled)](https://cran.r-project.org/package=labelled) 
![downloads](http://cranlogs.r-pkg.org/badges/grand-total/labelled)

**Online documentation:** http://larmarange.github.io/labelled/

# Labelled package for R

This package is built on the new class `labelled` introduced by **haven** package
and propose additional functions to manipulate labelled data.

Please note that this package is still under active development.

Missing values are currently not supported anymore by `labelled` package.

## Installation

From CRAN:

```r
install.packages("labelled")
```

Latest version from GitHub:

```r
devtools::install_github("larmarange/labelled")
```

## Introduction to labelled

Read http://larmarange.github.io/labelled/articles/intro_labelled.html

## Some general principles

1. Functions are intented to support `labelled` metadata structures only.
   However, `to_labelled` method allows to convert metadata 
   from **foreign** and **memisc** packages.
2. Functions should, by default, modify metadata only (i.e. classes and attributes), except if
   explicitly expressed by the user.

