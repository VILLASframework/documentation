DRAWIO_FIGURES = $(wildcard static/img/drawio/*.drawio)
SVG_FIGURES = $(DRAWIO_FIGURES:%.drawio=%.svg)

WEBM_VIDEOS = $(wildcard recordings/video/*.webm)
MP4_VIDEOS =  $(WEBM_VIDEOS:%.webm=%.mp4)

HOSTOS ?= $(shell uname -s)

ifeq ($(HOSTOS),Darwin)
DRAWIO ?= /Applications/draw.io.app/Contents/MacOS/draw.io
else
DRAWIO ?= drawio
endif

export LC_ALL = en_US.utf-8

all: videos docs

docs: build/index.html

videos: $(MP4_VIDEOS)

figures: $(SVG_FIGURES) 

clean:
	rm -f build/

build/index.html: figures examples
	yarn build

%.svg: %.drawio
	$(DRAWIO) -x -f svg -o $@ $^ 

%.mp4: %.webm
	ffmpeg -i $^ $@

examples:
	python3 tools/insert_examples.py

.PHONY: clean all deploy videos figures image upload run deploy examples
