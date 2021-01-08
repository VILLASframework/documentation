# Dockerfile for creating VILLASframework documentation
#
# @author Steffen Vogel <stvogel@eonerc.rwth-aachen.de>
# @copyright 2014-2019, Institute for Automation of Complex Power Systems, EONERC
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

FROM debian:buster AS builder

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8

RUN apt-get update && \
	apt-get -y install \
		git \
		doxygen \
		dia \
		graphviz \
		make \
		xsltproc \
		findutils \
		locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=en_US.UTF-8

RUN mkdir /doc
WORKDIR /doc
COPY .git		/doc/.git
COPY doc 		/doc/doc
COPY figures	/doc/figures
COPY filters	/doc/filters
COPY examples	/doc/examples
COPY images		/doc/images
COPY theme		/doc/theme
COPY usage		/doc/usage
COPY tools/searchdata-tagfile.xslt		/doc/tools/searchdata-tagfile.xslt
COPY Doxyfile	/doc/
COPY Makefile 	/doc/
COPY README.md	/doc/doc/README.md

RUN ls -l && make

FROM nginx:1.17.4

RUN apt-get update && \
	apt-get install -y \
		uwsgi \
		libxapian30 \
		supervisor \
		jq

RUN mkdir /usr/share/nginx/cgi-bin

RUN adduser --disabled-password --gecos '' uwsgi

COPY tools/nginx.conf /etc/nginx/nginx.conf
COPY tools/supervisord.conf /etc/supervisor/supervisord.conf
COPY tools/uwsgi.ini /etc/uwsgi/uwsgi.ini
COPY tools/jump.cgi /usr/share/nginx/cgi-bin/

COPY --from=builder /usr/bin/doxysearch.cgi /usr/share/nginx/cgi-bin/doxysearch.cgi
COPY --from=builder /doc/doxysearch.db/ /usr/share/nginx/cgi-bin/doxysearch.db/
COPY --from=builder /doc/html /usr/share/nginx/html/doc
COPY --from=builder /doc/images /usr/share/nginx/html/doc/images
COPY recordings/terminal /usr/share/nginx/html/doc/recordings/terminal

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf" ]
