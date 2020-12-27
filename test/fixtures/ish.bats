#!/usr/bin/env bats

load test_helper

@test "ish : shim should be required" {
  run . ../i.sh
  assert_output 'Please $(shim) before sourcing i.sh'
}

@test "ish :" {
  $(shim)
  . ../i.sh
  i:: log
  run log:: "my message"
  assert_output -p "my message"
}

