# Testing Arch with docker

Spin up container

    ./exec.sh

Then you can hook up the docker instance to commit changes

    git checkout feature/cardigans
    ./dotme set EMAIL dotfiles@purplepip.com
    ./create-deploy-key

Copy public deploy key into deploy key for repository

    cd ~
    mv ~/.dotfiles ~/.dotfiles.bak
    git clone git@github.com:ianhomer/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    git checkout feature/cardigans
