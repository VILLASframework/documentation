DRAWIO_FIGURES = $(wildcard static/img/drawio/*.drawio)
SVG_FIGURES = $(DRAWIO_FIGURES:%.drawio=%.svg)

WEBM_VIDEOS = $(wildcard recordings/video/*.webm)
MP4_VIDEOS =  $(WEBM_VIDEOS:%.webm=%.mp4)

DOCKER_IMAGE ?= registry.git.rwth-aachen.de/acs/public/villas/documentation
DOCKER_TAG ?= $(shell git rev-parse --abbrev-ref HEAD)

DRAWIO ?= /Applications/draw.io.app/Contents/MacOS/draw.io

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

image-dev:
	docker build \
		--target dev \
		--tag $(DOCKER_IMAGE):dev \
		--tag $(DOCKER_IMAGE):$(DOCKER_TAG)-dev .

image:
	docker build \
		--tag $(DOCKER_IMAGE):$(DOCKER_TAG) \
		--tag $(DOCKER_IMAGE):latest .

upload-dev: image-dev
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)-dev
	docker push $(DOCKER_IMAGE):dev

upload: image
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
	docker push $(DOCKER_IMAGE):latest

run: image
	docker run -p 8080:80 $(DOCKER_IMAGE):$(DOCKER_TAG)

dev: image-dev
	docker run \
		--publish 3000:3000 \
		--tty --interactive \
		--volume $(shell pwd):/documentation \
		--workdir /documentation \
		$(DOCKER_IMAGE):$(DOCKER_TAG)-dev

deploy:
	kubectl apply -f deployment.yaml
	kubectl -n fein rollout restart deployment villas-doc

.PHONY: clean all deploy videos figures image upload run deploy examples
