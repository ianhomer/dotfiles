#!/usr/bin/env bats

@test "should-run in error if no script provided" {
  run should-run
  [ $status -eq 3 ]
}

@test "should-run if never called before" {
  run should-run mock-script
  [ $status -eq 0 ]
}


