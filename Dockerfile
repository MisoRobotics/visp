#! syntax=docker/dockerfile:1.3
FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y \
    build-essential \
    cmake \
    git \
    # Recommended ViSP 3rd parties
    libopencv-dev \
    libx11-dev \
    liblapack-dev \
    libeigen3-dev \
    libdc1394-22-dev \
    libv4l-dev \
    libzbar-dev \
    libpthread-stubs0-dev \
    # Other optional 3rd parties
    libpcl-dev \
    libcoin-dev \
    libjpeg-dev \
    libpng-dev \
    libogre-1.9-dev \
    libois-dev \
    libdmtx-dev \
    libgsl-dev \
    && rm -rf /var/lib/apt/lists/*

ENV VISP_WS=/visp-ws VISP_INPUT_IMAGE_PATH=/visp-ws/visp-images
RUN mkdir -p ${VISP_WS} && git clone https://github.com/lagadic/visp-images.git ${VISP_INPUT_IMAGE_PATH} && rm -rf .git/
WORKDIR ${VISP_WS}

ADD . .
RUN mkdir build \
    && cmake -B build . \
    && make -C build "-j$(nproc)" \
    && make -C build install \
    && rm -rf build

WORKDIR /

LABEL maintainer="Fabien Spindler <Fabien.Spindler@inria.fr>"
