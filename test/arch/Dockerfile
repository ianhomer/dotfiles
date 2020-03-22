FROM archlinux:latest
RUN pacman -Syu --noconfirm git
RUN groupadd mygroup && \
    useradd -m -g mygroup me
USER me
RUN ls /home
RUN git clone https://github.com/ianhomer/dotfiles.git\
      ~/.dotfiles
#RUN ~/.dotfiles/bin/dotme

