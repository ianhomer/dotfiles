#!/usr/bin/env bats

load ../setup

@test "should-run in error if no script provided" {
  run should-run
  echo "output: $output"
  [ $status -eq 3 ]
}

@test "should-run if never called before" {
  should-run mock-script
}
