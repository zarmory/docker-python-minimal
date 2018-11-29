# docker-python-minimal
This repository contains stripped down version of official Python docker images.
The aim is to have an image that contains only Python *runtime* for use in the
final stage of multi-stage docker builds when tools like *pip* are not needed
(and even better be avoided to reduce potential attach surface).

Official images (alpine flavor) weigh 75-80MB. These stripped down images are less then 30MB.

More info about my approach on multi-stage builds for Python apps: https://tech.zarmory.com/2018/09/docker-multi-stage-builds-for-python-app.html

## Building
* `make build` - build images for Python versions listed in the top of the Makefile
* `make upload PUSH_REPO=<your repo>` - build and upload images to the specified repository.
   Uses `haizaar/python-minimal` by default

## Changes to the official images
* `strip`ped all of the Python dynamic libraries
* Removed "dev" part of the install
* Removed the following Python packages:
  * pip
  * ensurepip
  * idlelib
  * distutils
  * lib2to3

