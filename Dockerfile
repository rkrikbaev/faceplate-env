ARG TARGET_PLATFORM=x86_64

FROM rkrikbaev/erlang-${TARGET_PLATFORM}:latest

LABEL MAINTAINER="Rustam Krikbaev"

ENV REFRESHED_AT 2020-10-30

# install mc for future uses
RUN apt install -y python

# install dependencies needed for google_v8 javascript support
RUN apt install -y python3 pkg-config libncurses5-dev libtinfo5

COPY ecomet-env/patch/22.3/* /opt/erlang_patch/src

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

ENTRYPOINT [ "/bin/bash" ]
