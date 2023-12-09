#
# Slim image for dotfile validation
#
FROM ubuntu:latest
RUN apt update
RUN apt install -y stow git
RUN groupadd us && \
    useradd -m -g us me
RUN mkdir /etc/sudoers.d
RUN echo "me ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/me
RUN mkdir /home/me/.dotfiles/
COPY . /home/me/.dotfiles
USER me
RUN rm ~/.bashrc
# Only include shim and stow dotfile modules when dotme runs
RUN /home/me/.dotfiles/bin/dotme -i "shim|stow"
RUN /home/me/.dotfiles/start

WORKDIR /home/me

