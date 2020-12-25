FROM archlinux:latest
RUN pacman -Syu --noconfirm \
  git \ 
  openssh \
  sudo \
  vim
RUN groupadd us && \
    useradd -m -g us me
RUN echo "me ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/me
USER me
RUN git clone                                  \
      https://github.com/ianhomer/dotfiles.git \
      ~/.dotfiles
WORKDIR /home/me
