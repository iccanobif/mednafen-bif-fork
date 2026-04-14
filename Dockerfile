# mswin/build-toolchain.sh expects gcc 4.9.4
FROM gcc:4.9.4

WORKDIR /root/mswin
ADD ./mswin/ .
RUN ./fetch-toolchain-sources.sh

WORKDIR /root
ADD . .

# TODO: apt-get update fails, i suppose because gcc:4.9.4 is based on debian:jessie, which is no longer supported.
# configure: error: Building GCC requires GMP 4.2+, MPFR 2.4.0+ and MPC 0.8.0+.
# Try the --with-gmp, --with-mpfr and/or --with-mpc options to specify
# their locations.  Source code for these libraries can be found at
# their respective hosting sites as well as at
# ftp://gcc.gnu.org/pub/gcc/infrastructure/.  See also
# http://gcc.gnu.org/install/prerequisites.html for additional info.  If
# you obtained GMP, MPFR and/or MPC from a vendor distribution package,
# make sure that you have installed both the libraries and the header
# files.  They may be located in separate packages.
# RUN apt-get update \
#     && apt-get install -y --no-install-recommends \
#         libgmp-dev \
#         libmpfr-dev \
#         libmpc-dev \
#     && rm -rf /var/lib/apt/lists/*

# mswin/build-toolchain.sh expects gcc and g++ to be in the /usr/local/gcc-4.9.4/bin/
RUN mkdir -p /usr/local/gcc-4.9.4/bin \
    && ln -s /usr/local/bin/gcc /usr/local/gcc-4.9.4/bin/gcc \
    && ln -s /usr/local/bin/g++ /usr/local/gcc-4.9.4/bin/g++

# RUN ./build-toolchain.sh
# RUN ./build-mednafen.sh

# TODO: consider whether to run build-mednafen.sh with CMD instead of RUN

# FROM scratch AS export-stage
# COPY --from=builder /root/build64 /
# Decomment Run with `docker build --output type=local,dest=./build64 .` to export the mednafen binaries to the host machine.







# NOTES
# to make apt update work, replace /etc/apt/sources.list with the following content:
# deb http://archive.debian.org/debian jessie main

# also disable signature checking:
# echo "Acquire::Check-Valid-Until false;" > apt.conf

# This still doesn't seem to be enough, getting this error when running apt install:
# /sbin/ldconfig.real: /usr/local/lib64/libstdc++.so.6.0.20-gdb.py is not an ELF file - it has the wrong magic bytes at the start.
