DIA_FIGURES = $(wildcard figures/dia/*.dia)
SVG_FIGURES = $(DIA_FIGURES:%.dia=%.svg)

WEBM_VIDEOS = $(wildcard recordings/video/*.webm)
MP4_VIDEOS =  $(WEBM_VIDEOS:%.webm=%.mp4)

INPUT = $(shell find . -name "*.md") \
	$(shell find node/labs/etc -name "*.conf")

DEPLOY_USER ?= deploy
DEPLOY_HOST ?= acs-os-fein-website
DEPLOY_PATH ?= /var/www/villas/doc/

RSYNC_OPTS ?= --recursive --ignore-missing-args --copy-links --chown $(DEPLOY_USER):$(DEPLOY_USER)

export LC_ALL = en_US.utf-8

all: html/index.html doxysearch.db/ $(MP4_VIDEOS)

videos: $(MP4_VIDEOS)

figures: $(SVG_FIGURES)

clean:
	rm -f html/*.{png,js,html,svg,css,*.md5}

deploy: html/index.html
	rsync $(RSYNC_OPTS) html/ $(DEPLOY_USER)@$(DEPLOY_HOST):$(DEPLOY_PATH)
	rsync $(RSYNC_OPTS) doxysearch.db/ $(DEPLOY_USER)@$(DEPLOY_HOST):$(DEPLOY_PATH)/doxysearch.db/

html/index.html: $(INPUT) $(SVG_FIGURES) Doxyfile
	doxygen

searchdata.xml: html/index.html

doxysearch.db/: searchdata.xml
	doxyindexer $^

%.svg: %.dia
	dia -n -l -t svg -e $@ $^
	@# This fixes the location of inlined SVG images in DIA figures
	sed -i'' -e "s|file://$$(pwd)/||" $@

%.mp4: %.webm
	ffmpeg -i $^ $@

.PHONY: clean all deploy videos figures
