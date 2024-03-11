export PATH="../bin:$PATH"

if [[ "$OSTYPE" =~ ^darwin ]]; then
  TEST_BREW_PREFIX="$(brew --prefix)"
  LIB_PATH="${TEST_BREW_PREFIX}/lib"
else
  LIB_PATH=/usr/lib
fi
load "${LIB_PATH}/bats-support/load"
load "${LIB_PATH}/bats-assert/load"
