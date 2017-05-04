DIA_FIGURES = $(wildcard figures/dia/*.dia)
SVG_FIGURES = $(DIA_FIGURES:%.dia=%.svg)

INPUT = $(shell find . -name "*.md")

DEPLOY_USER ?= root
DEPLOY_HOST ?= villas.fein-aachen.org
DEPLOY_PATH ?= /var/www/villas/doc/

RSYNC_OPTS ?= --recursive --ignore-missing-args --copy-links --chown $(DEPLOY_USER):$(DEPLOY_USER)

export LC_ALL = en_US.utf-8

all: $(SVG_FIGURES) html/index.html

clean:
	rm -f html/*.{png,js,html,svg,css,*.md5}

deploy: all
	rsync $(RSYNC_OPTS) html/ $(DEPLOY_USER)@$(DEPLOY_HOST):$(DEPLOY_PATH)

html/index.html: $(INPUT)
	doxygen

%.svg: %.dia
	dia -n -l -t svg -e $@ $^

.PHONY: clean all deploy