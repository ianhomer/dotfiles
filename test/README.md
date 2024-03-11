# Testing

## Test dot scripts

  bats -T fixtures

## Testing autosave

Watch file and then edit it

    watch -n 1 -d cat test/scratch.md

## Test on a docker image

Run image

    docker run -it ubuntu:18.04 bash

Install and run with `test/os/ubuntu/install.sh` than run tests

    cd test/vim
    make test
