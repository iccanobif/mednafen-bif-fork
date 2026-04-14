# mswin/build-toolchain.sh expects gcc 4.9.4
FROM gcc:4.9.4

WORKDIR /root
ADD . .
WORKDIR /root/mswin
RUN ./fetch-toolchain-sources.sh

# mswin/build-toolchain.sh expects gcc and g++ to be in the /usr/local/gcc-4.9.4/bin/
RUN mkdir -p /usr/local/gcc-4.9.4/bin \
    && ln -s /usr/local/bin/gcc /usr/local/gcc-4.9.4/bin/gcc \
    && ln -s /usr/local/bin/g++ /usr/local/gcc-4.9.4/bin/g++

# RUN ./build-toolchain.sh
# RUN ./build-mednafen.sh

# TODO: consider whether to run build-mednafen.sh with CMD instead of RUN