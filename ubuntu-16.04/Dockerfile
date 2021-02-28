FROM ubuntu:16.04

ENV USER steam
ENV HOME_DIR /home/${USER}

# Add user
RUN useradd -m ${USER}

# Accept steam license agreement prior to installation
# https://askubuntu.com/questions/506909/how-can-i-accept-the-lience-agreement-for-steam-prior-to-apt-get-install/1017487#1017487
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections

# Install ca-certificates to fix "src/common/opensslconnection.cpp (1529) : Assertion Failed: unable to load trusted SSL root certificates"
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends ca-certificates steamcmd \
    && rm -rf /var/lib/apt/lists/*

# Create symlink for steamcmd
RUN ln -s /usr/games/steamcmd /usr/bin/steamcmd

# Update steamcmd to latest version
USER ${USER}
RUN steamcmd +quit

ENTRYPOINT ["steamcmd"]
CMD ["+help", "+quit"]