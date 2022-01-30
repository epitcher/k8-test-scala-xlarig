FROM ubuntu:21.10

# Needed to add update repositories
RUN apt-get -y update

RUN apt-get -y install git build-essential cmake automake libtool autoconf libhwloc-dev libuv1-dev libuv1-dev openssl libssl-dev

WORKDIR /app

RUN git clone https://github.com/scala-network/xlarig
RUN cd xlarig
RUN mkdir build
WORKDIR /app/xlarig/build
RUN cmake ../
RUN make -j$(nproc)

ADD config.json /app/xlarig/build/

# Use CMD to start miner
CMD ./xlarig