#!/bin/bash -e

if [ "$USING_DEBIAN" -eq "1" ]; then
    opensight/build.sh
else
    ${DOCKER} build -t opsi-main-git docker/main-git
    ${DOCKER} run --rm --privileged \
        --volume "$(pwd)":/packages \
        --name "opsi-deb" \
        opsi-main-git \
        bash -e -o pipefail -c \
        "cd packages; OPENSIGHT_VERSION=${OPENSIGHT_VERSION} opensight/build.sh"
fi
