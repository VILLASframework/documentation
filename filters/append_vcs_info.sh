#!/bin/bash

FILENAME=${1##$(pwd)/}

GITLAB_REPO="https://git.rwth-aachen.de/VILLASframework/Documentation"

GIT_LOG_FORMAT="Last updated on %ci by <a href=\"mailto:%aE\">%aN</a> (<a title=\"%s\" href=\"${GITLAB_REPO}/commit/%H\">%h</a>)"

HTML_VCS_EDIT="<img src="images/icons/edit.png" /> <a href=\"${GITLAB_REPO}/edit/master/${FILENAME}\">Edit this page</a>"
HTML_VCS_INFO=$(git log -n1 --format="${GIT_LOG_FORMAT}" ${FILENAME})

JSCODE="\$('#nav-path li.footer span.vcs-info').html('${HTML_VCS_INFO}');"
JSCODE+="\$('#nav-path li.footer span.vcs-edit').html('${HTML_VCS_EDIT}');"

cat "$FILENAME"

echo
echo
echo "@htmlonly <script>\$(function() { ${JSCODE} });</script> @endhtmlonly"