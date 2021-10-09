DIA_FIGURES = $(wildcard figures/dia/*.dia)
SVG_FIGURES = $(DIA_FIGURES:%.dia=%.svg)

WEBM_VIDEOS = $(wildcard recordings/video/*.webm)
MP4_VIDEOS =  $(WEBM_VIDEOS:%.webm=%.mp4)

DOCKER_IMAGE ?= registry.git.rwth-aachen.de/acs/public/villas/documentation/new
DOCKER_TAG ?= $(shell git rev-parse --abbrev-ref HEAD)

export LC_ALL = en_US.utf-8

all: videos docs

docs: build/index.html

videos: $(MP4_VIDEOS)

figures: $(SVG_FIGURES)

clean:
	rm -f build/

build/index.html: figures
	yarn build

%.svg: %.dia
	dia -n -l -t svg -e $@ $^
	@# This fixes the location of inlined SVG images in DIA figures
	sed -i'' -e "s|file://$$(pwd)/||" $@

%.mp4: %.webm
	ffmpeg -i $^ $@

image:
	docker build \
		--tag $(DOCKER_IMAGE):$(DOCKER_TAG) \
		--tag $(DOCKER_IMAGE):latest .

upload: image
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
	docker push $(DOCKER_IMAGE):latest

run: image
	docker run -p 8080:80 $(DOCKER_IMAGE):$(DOCKER_TAG)

deploy:
	kubectl apply -f deployment.yaml
	kubectl -n fein rollout restart deployment villas-doc-new

.PHONY: clean all deploy videos figures image upload run deploy
