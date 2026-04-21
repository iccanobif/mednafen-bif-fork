# mswin/build-toolchain.sh expects gcc 4.9.4
FROM gcc:4.9.4

WORKDIR /root/mswin
ADD ./mswin/ .
RUN ./fetch-toolchain-sources.sh

# Building GCC requires GMP 4.2+, MPFR 2.4.0+ and MPC 0.8.0+.
# Try the --with-gmp,
# http://gcc.gnu.org/install/prerequisites.html
# Info utili: https://syohex.hatenablog.com/entry/20110122/1295678868

# mswin/build-toolchain.sh expects gcc and g++ to be in the /usr/local/gcc-4.9.4/bin/
RUN mkdir -p /usr/local/gcc-4.9.4/bin \
    && ln -s /usr/local/bin/gcc /usr/local/gcc-4.9.4/bin/gcc \
    && ln -s /usr/local/bin/g++ /usr/local/gcc-4.9.4/bin/g++

WORKDIR /root/mswin
RUN ./build-toolchain.sh

WORKDIR /root/mswin/mednafen
ADD . .
RUN chmod +x configure

# RUN ./build-mednafen.sh

# TODO: consider whether to run build-mednafen.sh with CMD instead of RUN

# FROM scratch AS export-stage
# COPY --from=builder /root/build64 /
# Decomment Run with `docker build --output type=local,dest=./build64 .` to export the mednafen binaries to the host machine.

