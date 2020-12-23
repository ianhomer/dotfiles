#
# Slim image for dotfile validation
#
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
RUN mkdir /home/me/.dotfiles/
COPY . /home/me/.dotfiles
COPY ./dotfiles/.boot.bashrc.sh /home/me/.bashrc
WORKDIR /home/me
