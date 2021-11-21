FROM archlinux:latest
RUN pacman -Syu --noconfirm \
  base-devel \
  git     \
  openssh \
  sudo    \
  curl    \
  vim
RUN groupadd us && \
    useradd -m -g us me
RUN echo "me ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/me
USER me
WORKDIR /home/me

