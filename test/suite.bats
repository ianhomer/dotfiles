#!/usr/bin/env bats

load test_helper

@test "first test" {
  
  [ $status -eq 0 ]
  [ "$output" = "1..0" ]
}

