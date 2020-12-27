#!/usr/bin/env bats

load test_helper

@test "should-run : should be in error if no script provided" {
  run should-run
  assert_equal $status 3
}

@test "should-run : should run if not called before" {
  should-run mock-script-one-off
}

@test "should-run : should not run if called before" {
  should-run -c mock-script
  run should-run mock-script
  assert_equal $status 0
  should-run -fu mock-script
  run should-run mock-script
  assert_equal $status 1
}

