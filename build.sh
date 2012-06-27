#!/usr/bin/env bash
## ----------------------------------------------------------------------
## START OF FILE
## ----------------------------------------------------------------------
## 
## Filename: build.sh
## Author: Fred Qi
## Created: 2011-03-14 18:00:29(+0800)
## 
## ----------------------------------------------------------------------
### CHANGE LOG
## ----------------------------------------------------------------------
## Last-Updated: 2012-02-07 15:52:44(+0800) [by Fred Qi]
##     Update #: 11
## ----------------------------------------------------------------------

pkg=xdthesis

rm $pkg.{cls,cfg}

## ----------------------------------------------------------------------
## Generate XeLaTeX class files
## ----------------------------------------------------------------------
xelatex $pkg.ins

## ----------------------------------------------------------------------
## Generate the user guide
## ----------------------------------------------------------------------
xelatex $pkg.dtx
makeindex -s gind.ist $pkg.idx
makeindex -s gglo.ist -o $pkg.gls $pkg.glo
xelatex $pkg.dtx
xelatex $pkg.dtx

cd examples
scons -c && scons
cd ..

## ----------------------------------------------------------------------
## Generate the release package
## ----------------------------------------------------------------------
[[ -f xdthesis.7z ]] && rm xdthesis.7z

7z a -l xdthesis.7z xdthesis.{pdf,dtx,ins} examples/xdthesis.{cfg,cls} \
                    examples/{thesis-*,cover,ch01-intro}.tex examples/refs.bib \
	                examples/SConstruct

## ----------------------------------------------------------------------
### END OF FILE 
## ----------------------------------------------------------------------