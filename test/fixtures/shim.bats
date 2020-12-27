#!/usr/bin/env bats

load ../test_helper

@test "shim" {
  run shim
  echo "${lines}"
  [ ${#lines[@]} -eq 9 ]
}

@test "update shim" {
  shim -u
}
