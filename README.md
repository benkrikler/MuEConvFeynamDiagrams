MuEConvFeynamDiagrams
=====================
Feynman diagrams for mu-e conversion, mu-e decay and m->e gamma.  They use latex's `feynmp` package to draw things.

Usage
-----

The `mk_diagrams.sh` script should take care of the work to convert the tex file into an image.

Just do:
```
./mk_diagrams.sh mu_e_decay.tex
```

and you'll get the associated diagram in pdf and png form (as well as various auxiliary files).

The script assumes you have the following packages / commands installed:
 * ImageMagick's convert
 * pdfcrop
 * mpost
 * Latex packages:
    - feynmp
    - metapost
