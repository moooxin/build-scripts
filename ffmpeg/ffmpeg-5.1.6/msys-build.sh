#ndk工具链路径 -可配置
#FFmpeg源码路径
#https://blog.csdn.net/u013113678/article/details/125435571
#https://blog.csdn.net/qq_19272431/article/details/144828733

SRC_DIR=src
DST_DIR=build
#NDK路径
NDK=C:/Users/77462/AppData/Local/Android/Sdk/ndk/26.1.10909125/toolchains/llvm/prebuilt/windows-x86_64
API=34

cd $SRC_DIR

function build_onearch
{
    echo ">> configure $CPU start"
    ./configure \
      --enable-cross-compile \
      --target-os=android  \
      --prefix=$DST_DIR/$ANDROID_ABI  \
      --cross-prefix=$CROSS_PREFIX  \
      --cc=$CC \
      --cxx=$CXX \
      --strip=$NDK/bin/llvm-strip \
      --nm=$NDK/bin/llvm-nm \
      --arch=$ARCH \
      --sysroot=$NDK/sysroot \
      --enable-shared --disable-static \
      --enable-small --disable-programs --disable-doc \
      --enable-asm --enable-neon \
      --enable-jni --enable-mediacodec \
      --disable-vulkan \
      --cpu=$CPU  \
    echo "<< configure $CPU finish"
    make clean
    make
    make install
}

 #编arm64-v8a动态库
ANDROID_ABI=arm64-v8a
ARCH=arm64
CPU=armv8-a
CROSS_PREFIX=$NDK/bin/aarch64-linux-android$API-
CC=${CROSS_PREFIX}clang
CXX=${CROSS_PREFIX}clang++
build_onearch

 #编armeabi-v7a动态库
ANDROID_ABI=armeabi-v7a
ARCH=arm
CPU=armv7-a
CROSS_PREFIX=$NDK/bin/armv7a-linux-androideabi$API-
CC=${CROSS_PREFIX}clang
CXX=${CROSS_PREFIX}clang++
build_onearch


