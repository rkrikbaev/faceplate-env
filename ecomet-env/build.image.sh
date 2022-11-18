#!/bin/bash

while getopts ":c:n:v:p:" opt; do
  case $opt in
    c) CMD="$OPTARG"
    ;;
    n) NAME="$OPTARG"
    ;;
    v) VERSION="$OPTARG"
    ;;
    p) ARCH="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
    -*) echo "Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done

if [ CMD=="build" ]; then

echo "$ARCH"
echo "Build docker image for $ARCH platform"

if [ ARCH=="x86_64" ]; then
 BUILD_PLATFORM="linux/amd64"
elif [ ARCH=='arm64' ]; then
 BUILD_PLATFORM="linux/arm64"
elif [ ARCH=='arm' ]; then
 BUILD_PLATFORM="linux/arm/v7"
fi

if [ -z $VERSION ]; then
 VERSION="latest"
fi

#DIR=/home/user/$NAME

if [ -d $DIR ]; then
 echo "Trying to build ${NAME}-${ARCH}:${VERSION} on ${BUILD_PLATFORM}"
 sudo docker buildx build --platform ${BUILD_PLATFORM} --build-arg HOST_ARCH=${ARCH} -t fpcloud/${NAME}-${ARCH}:${VERSION} .

 #if [ $? -eq 0 ]; then
 # docker login
 # sudo docker push fpcloud/${NAME}-${ARCH}:${VERSION}
 #fi

#else
# echo "Path ${DIR} not exist"
# exit 2
fi
fi

#if [ $CMD=="test" ]; then
# docker run --rm -it -v data:/home/faceplate/faceplate fpcloud/faceplate-${ARCH}:${VERSION}
#fi
