#!/bin/bash
set -e

# Detect xbps package manager
if ! command -v xbps-install >/dev/null 2>&1; then
    echo "Error: xbps-install is not found. This script is for Void Linux only."
    exit 1
fi

# Detect musl vs glibc variant
if ldd --version 2>&1 | grep -qi musl; then
    echo "WARNING: Void Linux musl variant detected."
    echo "CRIU has limited support on musl libc."
    echo "Some features may not work. glibc variant is recommended."
    echo "Press Ctrl+C to abort, or wait 5 seconds to continue..."
    sleep 5
fi

# NOTE: On Void Linux, development headers are in separate -devel packages.
# CRIU needs both the runtime library AND the -devel package to compile.

# VERIFY: 'protobuf-c-devel' provides protoc-c compiler on Void.
# VERIFY: 'libbsd-devel' provides setproctitle() support.
# VERIFY: 'libtraceevent' and 'libtracefs' may need to be built from source
#         if not available in Void repos — check with: xbps-query -Rs libtrace
# VERIFY: 'bsdextrautils' has no direct Void equivalent — 'util-linux' covers most of it.
# VERIFY: 'asciidoctor' may need ruby gem instead: gem install asciidoctor

echo "Installing CRIU build dependencies for Void Linux..."

sudo xbps-install -Sy \
    asciidoc \
    autoconf \
    automake \
    bash \
    binutils \
    elfutils-devel \
    gdb \
    git \
    gnutls-devel \
    iproute2 \
    iptables \
    kmod \
    libaio-devel \
    libbpf-devel \
    libbsd-devel \
    libcap-devel \
    libdrm-devel \
    libnet-devel \
    libnl3-devel \
    libselinux-devel \
    make \
    nftables-devel \
    pkg-config \
    protobuf-c-devel \
    protobuf-devel \
    python3 \
    python3-pip \
    python3-protobuf \
    python3-setuptools \
    python3-yaml \
    util-linux-devel \
    xmlto

echo ""
echo "Dependencies installed successfully."
echo "Run ./contrib/dependencies/verify-packages.sh to confirm everything is set up."
