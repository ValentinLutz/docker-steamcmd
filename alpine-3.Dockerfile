FROM debian:buster-slim AS donor

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends ca-certificates lib32gcc1 curl \
    && rm -rf /var/lib/apt/lists/*

FROM alpine:3

# Add user
ENV USER steam
RUN adduser --disabled-password ${USER}

# Install dependencies
RUN apk update \
    && apk add --no-cache ca-certificates curl bash \
    && rm -rf /var/cache/apk/*
COPY --from=donor /lib32 /lib

# Install steamcmd manually
ENV STEAMCMD_DIR /home/${USER}/.steam
WORKDIR ${STEAMCMD_DIR}
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN chown -R ${USER}: ${STEAMCMD_DIR}

# Add script to run steamcmd 
COPY util/exec-steamcmd.sh /usr/local/bin/steamcmd
RUN chmod 755 /usr/local/bin/steamcmd

# Update steamcmd to latest version
USER ${USER}
RUN steamcmd +quit

ENTRYPOINT ["steamcmd"]
CMD ["+help", "+quit"]