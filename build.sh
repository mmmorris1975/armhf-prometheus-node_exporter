#!/bin/bash -x

ver=${VERSION:="0.16.0"}

NAME=$(basename $(dirname $PWD/Dockerfile))
URL="https://github.com/prometheus/node_exporter/releases/download/v${ver}/node_exporter-${ver}.linux-armv7.tar.gz"

wget -N $URL
tar xzf node_exporter-${ver}.linux-armv7.tar.gz --strip-components 1 --wildcards "*/node_exporter"

# It's better to run this directly on the node vs. inside a container, since we'd need to do all sorts of gymnastics
# to get the host OS stats exposed to the container.  Run install.sh instead to install as a system service
#docker build -t ${NAME}:${ver} -t ${NAME}:latest .
