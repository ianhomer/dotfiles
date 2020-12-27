#!/usr/bin/env bats

@test "shim" {
  run ../bin/shim
  echo "${lines}"
  [ ${#lines[@]} -eq 9 ]
}

@test "update shim" {
  run ../bin/shim -u
  [ ${#lines[@]} -eq 0 ]
}

