#!/bin/bash
mkdir /root/.ssh
cp -R $1/* /root/.ssh
chown root /root/.ssh/*
chmod 600 /root/.ssh/*