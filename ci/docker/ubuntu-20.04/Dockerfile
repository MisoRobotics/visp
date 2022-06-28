#! syntax=docker/dockerfile:1
FROM ubuntu:20.04
LABEL maintainer="Fabien Spindler <Fabien.Spindler@inria.fr>"
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris

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
RUN mkdir -p ${VISP_WS} && git clone https://github.com/lagadic/visp-images.git ${VISP_INPUT_IMAGE_PATH}
WORKDIR ${VISP_WS}

RUN git clone https://github.com/lagadic/visp && rm -rf .git \
    && mkdir build \
    && cmake -B build ../visp \
    && make -C build "-j$(nproc)" \
    && make -C build install \
    && rm -rf build

WORKDIR /
