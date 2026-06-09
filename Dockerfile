FROM ubuntu:22.04

ARG LIBREALSENSE_VERSION=v2.58.1
ARG NUM_JOBS=6
ARG DEBIAN_FRONTEND=noninteractive

LABEL org.opencontainers.image.description="librealsense ${LIBREALSENSE_VERSION} SDK base — ubuntu:22.04 aarch64"
LABEL librealsense.version="${LIBREALSENSE_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    pkg-config \
    libssl-dev \
    libusb-1.0-0-dev \
    libudev-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
    
RUN git clone \
        --branch ${LIBREALSENSE_VERSION} \
        --depth 1 \
        https://github.com/realsenseai/librealsense.git /tmp/librealsense \
    && mkdir -p /tmp/librealsense/build \
    && cd /tmp/librealsense/build \
    && cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_EXAMPLES=FALSE \
        -DBUILD_GRAPHICAL_EXAMPLES=FALSE \
        -DBUILD_PYTHON_BINDINGS=FALSE \
        -DBUILD_UNIT_TESTS=FALSE \
    && make -j${NUM_JOBS} \
    && make install \
    && ldconfig \
    && mkdir -p /opt/realsense/udev \
    && cp /tmp/librealsense/config/99-realsense-libusb.rules /opt/realsense/udev/ \
    && cp /tmp/librealsense/config/99-realsense-d4xx-mipi-dfu.rules /opt/realsense/udev/ \
    && rm -rf /tmp/librealsense
