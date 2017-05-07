#!/bin/bash

FILENAME=$1

GITLAB_REPO="https://git.rwth-aachen.de/VILLASframework/Documentation"

GIT_LOG_FORMAT="Last updated on %ci by <a href=\"mailto:%aE\">%aN</a> (<a title=\"%s\" href=\"${GITLAB_REPO}/commit/%H\">%h</a>)"
GIT_LOG=$(git log -n1  --format="${GIT_LOG_FORMAT}" ${FILENAME})

JSCODE="\$('#nav-path > ul > li.footer').prepend('<span class=\"vcs\">${GIT_LOG}</span>');"

cat "$FILENAME"

echo
echo "@htmlonly <script>\$(function() { ${JSCODE} });</script> @endhtmlonly"