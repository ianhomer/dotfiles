#!/usr/bin/env bats

@test "shim" {
  run shim
  echo "${lines}"
  [ ${#lines[@]} -eq 9 ]
}

@test "update shim" {
  shim -u
}

