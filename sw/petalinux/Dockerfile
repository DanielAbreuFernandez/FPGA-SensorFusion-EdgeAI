# ------------------------------------------------------------
# PetaLinux 2025.1 Docker (Zynq-7000 / Arty Z7)
# ------------------------------------------------------------
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# ------------------------------------------------------------
# Install ALL required PetaLinux dependencies
# ------------------------------------------------------------
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y \
    gawk wget git diffstat unzip texinfo gcc build-essential \
    chrpath socat cpio python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping libegl1-mesa \
    libsdl1.2-dev pylint xterm autoconf libtool tar \
    zlib1g-dev libncurses5-dev libncursesw5-dev \
    libssl-dev flex bison libselinux1 gnupg \
    screen sudo locales rsync bc file \
    gcc-multilib lsb-release \
    libstdc++6:i386 libncurses5:i386 libz1:i386 \
    libtinfo5 \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# Locale setup
# ------------------------------------------------------------
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# ------------------------------------------------------------
# Create non-root user (PetaLinux requirement)
# ------------------------------------------------------------
ARG USERNAME=petalinux
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID $USERNAME && \
    useradd -m -u $UID -g $GID -s /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# ------------------------------------------------------------
# Copy installer as root
# ------------------------------------------------------------
WORKDIR /tmp
COPY petalinux-v2025.1-*-installer.run /tmp/petalinux-installer.run
RUN chmod +x /tmp/petalinux-installer.run

# ------------------------------------------------------------
# Switch to non-root for installation
# ------------------------------------------------------------
USER $USERNAME
WORKDIR /home/$USERNAME

# Install ONLY Zynq (arm) sources
RUN /tmp/petalinux-installer.run \
    --dir /home/$USERNAME/petalinux \
    --platform "arm" \
    -y

# Switch back to root to clean up installer
USER root
RUN rm -f /tmp/petalinux-installer.run

# Switch back to petalinux user
USER $USERNAME

# Auto-source on login
RUN echo "source ~/petalinux/settings.sh" >> ~/.bashrc

WORKDIR /home/$USERNAME/work

CMD ["/bin/bash"]
