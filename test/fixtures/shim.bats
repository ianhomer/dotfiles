#!/usr/bin/env bats

load test_helper

shim
@test "shim : should output correct number of variables" {
  run shim
  assert_equal ${#lines[@]} 13
}

@test "shim : should update without error" {
  shim -u
}
