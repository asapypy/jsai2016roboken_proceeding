### delete default rules
.DEFAULTS:
### delete default suffixes
.SUFFIXES:
### define my original suffixes
.SUFFIXES: .tex .dvi .pdf .eps .obj .gpt .xbb .jpeg .jpg .png .ind .bbl .idx	.ist
CLEAN_EXTS := dvi aux log bbl blg out idx

TARGET=jsai2016roboken
### for Mac OSX
TEXBINDIR=/Library/TeX/texbin
BINDIR=/usr/local/bin
OPEN=open

UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
### for Ubuntu
TEXBINDIR=/usr/local/texlive/2015/bin/x86_64-linux
OPEN=LD_LIBRARY_PATH='' evince
endif

BIB=asakawa.bib
SRC=$(TARGET).tex
DVI=$(TARGET).dvi
PDF=$(TARGET).pdf
BIB=asakawa.bib
STY=jsaiac.sty
FIGS=
BBFILES=
ALLFILES=$(SRC) $(PDF) $(BIB) $(FIGS) $(STY) Makefile

LATEX=$(TEXBINDIR)/platex
BIBTEX=$(TEXBINDIR)/pbibtex
DVIPDFMX=$(TEXBINDIR)/dvipdfmx
DVIPDFMX=$(TEXBINDIR)/dvipdfmx
GNUPLOT=$(BINDIR)/gnuplot
TGIF=$(BINDIR)/tgif
TGIFOPS=-print -eps -color
TAR=$(BINDIR)/tar
ZIP=$(BINDIR)/gzip
XBB=$(BINDIR)/xbb

all: $(PDF)

$(PDF): $(DVI)
$(DVI): $(BIB) $(SRC)

.tex.dvi:
	$(LATEX) $(*F)
	$(LATEX) $(*F)
	$(LATEX) $(*F)
	$(BIBTEX) $(*F)
	$(LATEX) $(*F)
	$(LATEX) $(*F)
	$(LATEX) $(*F)

.dvi.pdf:
	$(DVIPDFMX) $<

.obj.eps:
	$(TGIF) $(TGIFOPS) $<

.gpt.eps:
	$(GNUPLOT) $<

.jpg.xbb:
	$(XBB) $<

.jpeg.xbb:
	$(XBB) $<

.png.xbb:
	$(XBB) $<

.pdf.xbb:
	$(XBB) $<

edit: $(SRC)
	open $(SRC)

view: $(PDF)
	$(OPEN) $<

cleanfiles:
	$(eval CLEAN_FILES := $(strip \
		$(foreach ext,$(CLEAN_EXTS), $(shell find . -name '*$(ext)' ))))

cleanlist: cleanfiles
	@ \
	if [ -z "$(CLEAN_FILES)" ]; then \
		echo "No generated files found."; \
	else \
		echo $(CLEAN_FILES) | tr ' ' '\n'; \
	fi

clean: cleanfiles
	@ \
	if [ -z "$(CLEAN_FILES)" ]; then \
		echo "No generated files found."; \
	else \
		echo "Deleting the following generated files:"; \
		echo $(CLEAN_FILES) | tr ' ' '\n'; \
		$(RM) $(CLEAN_FILES); \
	fi
	if [ -f "$(TARGET).pdf" ]; then \
		$(RM) $(TARGET).pdf; \
	fi
