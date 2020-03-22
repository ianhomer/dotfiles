# Testing with docker

    docker build -t local/dotme -f Dockerfile .
    docker run --rm -it local/dotme

Then you can hook up the docker instance to commit changes

    cd ~/.dotfiles/bin
    git checkout feature/jelly
    ./dotme set EMAIL dotfiles@purplepip.com
    ./create-deploy-key

Copy public deploy key into deploy key for repository

    cd ~
    mv ~/.dotfiles ~/.dotfiles.bak
    git clone git@github.com:ianhomer/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    git checkout feature/jelly



