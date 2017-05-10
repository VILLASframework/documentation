#!/bin/bash

FILENAME=${1##$(pwd)/}

GITLAB_REPO="https://git.rwth-aachen.de/VILLASframework/Documentation"

GIT_LOG_FORMAT="Last updated on %ci by <a href=\"mailto:%aE\">%aN</a> (<a title=\"%s\" href=\"${GITLAB_REPO}/commit/%H\">%h</a>)"

HTML_VCS_EDIT="<a title=\"Edit this page in GitLab\" href=\"${GITLAB_REPO}/edit/master/${FILENAME}\">Edit this page&nbsp;<img src="images/icons/edit.png" /></a>"
HTML_VCS_INFO=$(git log -n1 --format="${GIT_LOG_FORMAT}" ${FILENAME})

JSCODE="\$('.vcs-info').html('${HTML_VCS_INFO}');"
JSCODE+="\$('#main-menu').append('<li class=\"vcs-edit\">${HTML_VCS_EDIT}</li>');"

cat "$FILENAME"

echo
echo
echo "@htmlonly <script>\$(function() { ${JSCODE} });</script> @endhtmlonly"