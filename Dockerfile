ARG UBUNTU=library/ubuntu:focal
ARG DEBIAN_FRONTEND="noninteractive"
ARG VIRTUALBOX_VERSION="6.1.26"
FROM ${UBUNTU} AS deps
ARG DEBIAN_FRONTEND
RUN set -eux \
 && apt-get -y update
RUN set -eux \
 && apt-get -y install --no-install-recommends \
    binutils \
    curl \
    gcc \
    g++ \
    iproute2 \
    lsb-release \
    mesa-opencl-icd \
    openssl \
    procps \
    python3 \
    util-linux \
    x11-common \
    xz-utils

FROM deps AS source
ARG DEBIAN_FRONTEND
ARG VIRTUALBOX_VERSION
RUN set -eux \
 && apt-get -y install --no-install-recommends \
    virtualbox=$(apt-cache show virtualbox | grep -E "Version[:] ${VIRTUALBOX_VERSION#v}" | head -1 | awk '{print $2}') \
    virtualbox-source=$(apt-cache show virtualbox-source | grep -E "Version[:] ${VIRTUALBOX_VERSION#v}" | head -1 | awk '{print $2}')

FROM deps AS dkms
ARG DEBIAN_FRONTEND
ARG VIRTUALBOX_VERSION
RUN set -eux \
 && apt-get -y install --no-install-recommends \
    virtualbox=$(apt-cache show virtualbox | grep -E "Version[:] ${VIRTUALBOX_VERSION#v}" | head -1 | awk '{print $2}') \
    virtualbox-dkms=$(apt-cache show virtualbox-dkms | grep -E "Version[:] ${VIRTUALBOX_VERSION#v}" | head -1 | awk '{print $2}')
