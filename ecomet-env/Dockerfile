# Target version
ARG OTP_VERSION=22.3
ARG BUILD_ARCH=''
ARG TARGET_PLATFORM=''

# Source erlang
FROM fpcloud/erlang-env-${TARGET_PLATFORM}:latest
MAINTAINER Roman Vozzhenikov "vzroman@faceplate.io"
ENV REFRESHED_AT 2020-10-29

# install mc for future uses
RUN apt-get -y install mc python

# install dependencies needed for google_v8 javascript support
RUN apt-get -y install python3 pkg-config libncurses5-dev libtinfo5

COPY patch/22.3/* /opt/erlang_patch/src
#COPY install-ssh.sh /opt/
#RUN chmod +x /opt/install-ssh.sh

# Ecomet patch for mnesia
RUN cd /usr/local/lib && \
	for e in erlang*; \
	do \
		echo "patching $e" && \
		\cp -R /opt/erlang_patch/* $e/lib/mnesia-*/ && \
		cd $e/lib/mnesia-* && \
		for m in src/*.erl ; \
		do \
			erlc -I include -pa ebin -o ebin $m \
		; done && \
		cd /usr/local/lib \
	; done

ENTRYPOINT [ "/bin/bash/" ]
