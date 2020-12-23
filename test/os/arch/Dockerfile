FROM archlinux:latest
RUN pacman -Syu --noconfirm \
  git \ 
  openssh \
  vim
RUN groupadd mygroup && \
    useradd -m -g mygroup me
USER me
RUN git clone                                  \
      -b feature/cardigans                     \
      https://github.com/ianhomer/dotfiles.git \
      ~/.dotfiles
WORKDIR /home/me
