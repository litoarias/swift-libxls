#!/bin/bash
set -e

REPO="https://github.com/libxls/libxls.git"

ROOT=$(pwd)
BUILD="$ROOT/build-libxls"
SRC="$BUILD/libxls"

echo "== limpiar build =="
rm -rf "$BUILD"
mkdir -p "$BUILD"

echo "== clonar repo =="
git clone --depth 1 "$REPO" "$SRC"

cd "$SRC"

echo "== crear config.h minimal =="

cat > include/config.h <<EOF
#define HAVE_ICONV 1
#define HAVE_STDLIB_H 1
#define HAVE_STRING_H 1
#define HAVE_STRINGS_H 1
#define STDC_HEADERS 1

#define PACKAGE_NAME "libxls"
#define PACKAGE_VERSION "1.6.2"
#define PACKAGE_STRING "libxls"
#define PACKAGE_TARNAME "libxls"

#define ICONV_CONST const
EOF

echo "== preparar carpetas =="

mkdir -p "$BUILD/ios"
mkdir -p "$BUILD/sim"

IOS_SDK=$(xcrun --sdk iphoneos --show-sdk-path)
SIM_SDK=$(xcrun --sdk iphonesimulator --show-sdk-path)

echo "== detectar archivos fuente =="

CFILES=$(find src -name "*.c" ! -name "xlstool.c")

echo "$CFILES"

echo "== compilar iOS device =="

for f in $CFILES; do
name=$(basename "$f" .c)

xcrun --sdk iphoneos clang \
-arch arm64 \
-isysroot "$IOS_SDK" \
-Iinclude \
-O2 \
-c "$f" \
-o "$BUILD/ios/$name.o"

done

libtool -static -o "$BUILD/libxls_ios.a" "$BUILD/ios/"*.o

echo "== compilar simulator =="

for f in $CFILES; do
name=$(basename "$f" .c)

xcrun --sdk iphonesimulator clang \
-arch arm64 \
-arch x86_64 \
-isysroot "$SIM_SDK" \
-Iinclude \
-O2 \
-c "$f" \
-o "$BUILD/sim/$name.o"

done

libtool -static -o "$BUILD/libxls_sim.a" "$BUILD/sim/"*.o

echo "== crear XCFramework =="

xcodebuild -create-xcframework \
-library "$BUILD/libxls_ios.a" -headers include \
-library "$BUILD/libxls_sim.a" -headers include \
-output "$BUILD/libxls.xcframework"

echo ""
echo "XCFramework generado en:"
echo "$BUILD/libxls.xcframework"