FROM ubuntu:22.04

ARG USERNAME=$USERNAME
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    bats \
    kcov \
    sudo \
    snapd \
    tzdata \
    parallel \
    build-essential \
    ca-certificates

#https://forums.balena.io/t/create-user-with-sudo-privilege/350303/6
# Set environment variables
ENV USER=${USERNAME}
ENV HOME=/home/${USERNAME}

# Create user and setup permissions on /etc/sudoers
RUN useradd -m -s /bin/bash -N -u $USER_UID $USERNAME && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
    chmod 0440 /etc/sudoers && \
    chmod g+w /etc/passwd

USER $USERNAME
WORKDIR /home/$USERNAME/.local/share/chezmoi

RUN sudo /bin/bash -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

RUN mkdir -p ~/.local/share/fonts
RUN mkdir -p /tmp

CMD ["/bin/bash"]