#!/usr/bin/env bats

load test_helper

@test "shim" {
  run shim
  assert_equal ${#lines[@]} 9
}

@test "update shim" {
  shim -u
}
