# Dockerfile for creating VILLASframework documentation
#
# Author: Steffen Vogel <post@steffenvogel.de>
# SPDX-FileCopyrightText: 2014-2022 Institute for Automation of Complex Power Systems, EONERC
# SPDX-FileCopyrightText: 2025 OPAL-RT Germany GmbH
# SPDX-License-Identifier: Apache-2.0
###################################################################################

FROM node:24.0.0-bookwork AS deps

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8

RUN apt-get update && \
	apt-get -y install \
	git \
	dia \
	make \
	xsltproc \
	findutils \
	locales \
	python3

RUN yarn global add @redocly/cli

FROM deps AS dev

# create a non-root user for vscode to use
ARG USERNAME=node
RUN apt-get install sudo \
	&& echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
	&& chmod 0440 /etc/sudoers.d/$USERNAME

EXPOSE 3000

ENTRYPOINT [ "yarn", "start", "--host", "0.0.0.0" ]

FROM deps AS builder

RUN mkdir /doc
WORKDIR /doc

COPY package.json .
RUN yarn

COPY . .
RUN make docs

FROM docker.io/library/nginx:1.21.3

COPY --from=builder /doc/build /usr/share/nginx/html
