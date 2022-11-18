#!/bin/bash

DIR=$1
TAG=$2

cp -R /home/.ssh/* /root/.ssh
chown root /root/.ssh/*
chmod 600 /root/.ssh/*

#git clone git@git.faceplate.io:fp/faceplate.git $DIR

if [ -d $DIR ]; then
 cd $DIR
 git fetch --all --tags --prune
 git checkout tags/${TAG} -b build_${TAG}
else
 exit 2
fi

if [ $? -eq 0 ]; then
  ./rebar3 compile
  if [ $? -eq 0 ]; then
    ./rebar3 as prod release
    if [ $? -ne 0 ]; then
      exit 1
    fi
  else
    exit 1
  fi
else
  exit 2
fi

BUILD_DIR=${DIR}/_build/prod/rel/faceplate

if [ -d $BUILD_DIR ]; then
 cp -R $BUILD_DIR/* /fp/release/faceplate
fi 
