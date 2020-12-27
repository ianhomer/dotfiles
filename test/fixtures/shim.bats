#!/usr/bin/env bats

@test "shim" {
  run shim
  echo "${lines}"
  [ ${#lines[@]} -eq 9 ]
}

@test "update shim" {
  run shim -u
  [ ${#lines[@]} -eq 0 ]
}

