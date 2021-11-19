#
# Slim image for dotfile validation
#
FROM archlinux:latest
RUN pacman -Syu --noconfirm \
  git \
  openssh \
  stow \
  sudo \
  vim
RUN groupadd us && \
    useradd -m -g us me
RUN echo "me ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/me
RUN mkdir /home/me/.dotfiles/
COPY . /home/me/.dotfiles
COPY ./dotfiles/.boot.bashrc.sh /home/me/.boot.bashrc.sh
USER me
# Only include shim and stow dotfile modules when dotme runs
RUN /home/me/.dotfiles/bin/dotme -i "shim|stow"
WORKDIR /home/me
