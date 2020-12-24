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
      pdal \
    # build dependency
      git \
      build-essential \
      python3-dev \
    && cd /usr/src \
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
    && rm -rf /var/lib/apt/lists/*

COPY entry_point.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/entry_point.sh"]
