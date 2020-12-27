#!/usr/bin/env bats

@test "should-run in error if no script provided" {
  run ../bin/should-run
  echo "output: $output"
  [ $status -eq 3 ]
}

@test "should-run if never called before" {
  ../bin/should-run mock-script
}
