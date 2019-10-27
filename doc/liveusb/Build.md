# Build new LiveUSB images {#liveusb-build}

Images are build with Fedora's [livemedia-creator](http://lorax.readthedocs.io/en/latest/livemedia-creator.html) and using a custom [Anaconda Kickstart file](https://git.rwth-aachen.de/acs/public/villas/images/tree/master/villas-live.ks).
A guide for this method can be found here: https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD

We build the images using the RWTH GitLab continous integration system. Which itself is using a Docker container.
This makes the process as reproducible as possible.

Every tagged Git commit which is pushed to the GitLab server will trigger the generation of a new ISO.
New ISO images will be pushlished automtically at: http://villas.fein-aachen.org/iso/beta/

The Git repository including all the scripts is available here: http://git.rwth-aachen.de/acs/public/villas/images
