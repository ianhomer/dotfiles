#!/usr/bin/env bats

load ../setup

@test "shim" {
  run shim
  echo "${lines}"
  [ ${#lines[@]} -eq 9 ]
}

@test "update shim" {
  shim -u
}
