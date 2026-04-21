#!/bin/bash
set -euo pipefail

DEST_DIR="${1:-${HOME}/mednafen-cross-sources}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$DEST_DIR"

fetch() {
  local url="$1"
  local out="$2"

  if [ -f "$DEST_DIR/$out" ]; then
    echo "Already present: $out"
    return
  fi

  echo "Downloading: $out"
  curl -fL "$url" -o "$DEST_DIR/$out"
}

fetch "https://ftp.gnu.org/gnu/binutils/binutils-2.28.1.tar.xz" "binutils-2.28.1.tar.xz"
fetch "https://downloads.sourceforge.net/project/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v5.0.5.tar.bz2" "mingw-w64-v5.0.5.tar.bz2"
fetch "https://ftp.gnu.org/gnu/gcc/gcc-4.9.4/gcc-4.9.4.tar.bz2" "gcc-4.9.4.tar.bz2"
fetch "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz" "libiconv-1.15.tar.gz"
fetch "https://downloads.xiph.org/releases/flac/flac-1.3.4.tar.xz" "flac-1.3.4.tar.xz"
fetch "https://www.zlib.net/fossils/zlib-1.2.13.tar.gz" "zlib-1.2.13.tar.gz"
fetch "https://github.com/libsdl-org/SDL/releases/download/release-2.28.5/SDL2-2.28.5.tar.gz" "SDL2-2.28.5.tar.gz"

# fetch "https://gcc.gnu.org/pub/gcc/infrastructure/gmp-4.3.2.tar.bz2" "gmp-4.3.2.tar.bz2"
# fetch "https://gcc.gnu.org/pub/gcc/infrastructure/gmp-6.3.0.tar.bz2" "gmp-6.3.0.tar.bz2"
# fetch "https://gcc.gnu.org/pub/gcc/infrastructure/mpc-0.8.1.tar.gz" "mpc-0.8.1.tar.gz"
# fetch "https://gcc.gnu.org/pub/gcc/infrastructure/mpc-1.3.1.tar.gz" "mpc-1.3.1.tar.gz"
# fetch "https://gcc.gnu.org/pub/gcc/infrastructure/mpfr-2.4.2.tar.bz2" "mpfr-2.4.2.tar.bz2"
# fetch "https://gcc.gnu.org/pub/gcc/infrastructure/mpfr-4.2.2.tar.bz2" "mpfr-4.2.2.tar.bz2"

cp "$SCRIPT_DIR/gcc-4.9.4-mingw-w64-noforcepic-smalljmptab.patch" "$DEST_DIR/"
cp "$SCRIPT_DIR/zlib-1.2.13-mingw-w64.patch" "$DEST_DIR/"
cp "$SCRIPT_DIR/SDL2-2.28.5-win2000.patch" "$DEST_DIR/"
cp "$SCRIPT_DIR/SDL2-2.28.5-altgr-grab.patch" "$DEST_DIR/"

echo "Toolchain sources are ready in: $DEST_DIR"
