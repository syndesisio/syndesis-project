#!/bin/bash


# Simple script for pulling from brew and push to the ignite cluster. 
# This scripts works a long as all brew images have the same version (including build number)
#
# PLEASE CHECK THE VERSIONS BEFORE RUNNING THE SCRIPT !!!
#
# For more complex situation (including imports of pipeline builds), refer to migrate-images.pl
#
# Support images like oauth-proxy and FIS builder images are imported, too.
set -euo pipefail

IGNITE_REGISTRY="registry.fuse-ignite.openshift.com/fuse-ignite"
IGNITE_VERSION=${1:-"1.1"}

BREW_REGISTRY="brew-pulp-docker01.web.prod.ext.phx2.redhat.com:8888/jboss-fuse-7-tech-preview"
BREW_VERSION=${2:-"1.1-1"}

IGNITE_PL=$(echo $BREW_VERSION | sed -e 's/^\(.*\)-\([0-9]*\)$/\2/')

IMAGES=${3:-"fuse-ignite-mapper fuse-ignite-rest fuse-ignite-ui fuse-ignite-verifier"}

# Push all images to target regitry
# Also push links to head versions (i.e. 1.0 -> 1.0.0)
for image in ${IMAGES}; do
  docker pull ${BREW_REGISTRY}/${image}:${BREW_VERSION}
  docker tag ${BREW_REGISTRY}/${image}:${BREW_VERSION} ${IGNITE_REGISTRY}/${image}:${IGNITE_VERSION}
  docker tag ${BREW_REGISTRY}/${image}:${BREW_VERSION} ${IGNITE_REGISTRY}/${image}:${IGNITE_VERSION}.${IGNITE_PL}
  docker push ${IGNITE_REGISTRY}/${image}:${IGNITE_VERSION}
  docker push ${IGNITE_REGISTRY}/${image}:${IGNITE_VERSION}.${IGNITE_PL}
done

# Push OpenShift OAuth proxy to ignite registry:
OAUTH_PROXY="oauth-proxy:v1.0.0";
docker pull "docker.io/openshift/${OAUTH_PROXY}"
docker tag "docker.io/openshift/${OAUTH_PROXY}" "${IGNITE_REGISTRY}/${OAUTH_PROXY}"
docker push "${IGNITE_REGISTRY}/${OAUTH_PROXY}"

# Push FIS s2i builder image (decoupled from Syndesis version)
S2I_IMAGE_SRC="registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0-13"
S2I_IMAGE_TARGET="fuse-ignite-java-openshift:1.0"
docker pull ${S2I_IMAGE_SRC}
docker tag ${S2I_IMAGE_SRC} ${IGNITE_REGISTRY}/${S2I_IMAGE_TARGET}
docker push ${IGNITE_REGISTRY}/${S2I_IMAGE_TARGET}
