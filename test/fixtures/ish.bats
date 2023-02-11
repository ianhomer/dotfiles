#!/usr/bin/env bats

load test_helper

@test "ish : shim should be required" {
  run . ../bin/i.sh
  assert_output 'Please $(shim) before sourcing i.sh'
}

@test "ish : should be able to load OK" {
  $(shim)
  . ../bin/i.sh
  i:: log
  run log:: "my message"
  assert_output -p "my message"
}

