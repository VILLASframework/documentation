# Dockerfile for creating VILLASframework documentation
#
# @author Steffen Vogel <post@steffenvogel.de>
# @copyright 2014-2022, Institute for Automation of Complex Power Systems, EONERC
# @license GNU General Public License (version 3)
#
# VILLASnode
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
###################################################################################

FROM node:16-bullseye AS deps

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

FROM deps AS vscode

# create a non-root user for vscode to use
ARG USERNAME=node
RUN apt-get install sudo \
	&& echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
	&& chmod 0440 /etc/sudoers.d/$USERNAME

ENTRYPOINT [ "bash" ]

FROM deps AS builder

RUN mkdir /doc
WORKDIR /doc

RUN yarn global add @redocly/cli

COPY package.json .
RUN yarn

COPY . .
RUN make docs

FROM nginx:1.21.3

COPY --from=builder /doc/build /usr/share/nginx/html
