FROM ubuntu:20.04
LABEL maintainer="Taro Matsuzawa (taro@georepublic.co.jp)"

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
      python3 \
      python3-pip \
      libopenblas-base \
      libgdal26 \
      liblaszip8 \
      libunwind8 \
    # build dependency
      git \
      build-essential \
      python3-dev \
      wget \
      cmake \
      libgdal-dev \
      liblaszip-dev \
      libunwind-dev \
    && cd /usr/src \
    && wget https://github.com/PDAL/PDAL/releases/download/2.2.0/PDAL-2.2.0-src.tar.gz \
    && tar zxf PDAL-2.2.0-src.tar.gz \
    && cd PDAL-2.2.0-src \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && cd /usr/src/ \
    && rm -fr PDAL-2.2.0-src \
    && git clone https://gitlab.com/Oslandia/py3dtiles.git \
    && cd /usr/src/py3dtiles \
    && git checkout 58d852eff46352a04b4e56cc34da7ef62a1a8d28 \
    && pip3 install setuptools \
    && pip3 install -e . \
    && python3 setup.py install \
    && cd /usr/src \
    && rm -fr /usr/src/py3dtiles \
    && apt-get remove -y \
      git \
      build-essential \
      python3-dev \
      wget \
      cmake \
      libgdal-dev \
      liblaszip-dev \
      libunwind-dev \
    && rm -rf /var/lib/apt/lists/*

COPY entry_point.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/entry_point.sh"]
