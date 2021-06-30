#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# Uncomment the following line to debug stub failures
# export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

@test "Fails if the env variable `BUILDKITE_PLUGIN_REPO_SHALLOW_CLONE_RUN_ON_PULL_REQUESTS` is unset" {

  export BUILDKITE_PULL_REQUEST=false
  export BUILDKITE_PLUGIN_REPO_SHALLOW_CLONE_DEPTH=1
  unset BUILDKITE_PLUGIN_REPO_SHALLOW_CLONE_RUN_ON_PULL_REQUESTS

  run "$PWD/hooks/pre-checkout"

  assert_failure
  assert_output --partial "+++ repo shallow clone plugin error"
  assert_output --partial "The property `run_on_pull_requests` is not configured."
}

@test "Set the git flags if it's not a pull requests and if it doesn't run on pull requests" {

  export BUILDKITE_PULL_REQUEST=false
  export BUILDKITE_PLUGIN_REPO_SHALLOW_CLONE_RUN_ON_PULL_REQUESTS=false

  unset BUILDKITE_PLUGIN_REPO_SHALLOW_CLONE_DEPTH
  unset BUILDKITE_GIT_CLONE_FLAGS
  
  run "$PWD/hooks/pre-checkout"

  assert_success
  assert_output "Correctly set the values of the git clone flags to -v --depth 1"
}

@test "Doesn't run if it's a pull request and the env variable is set correctly to not run" {

  export BUILDKITE_PULL_REQUEST=true
  export BUILDKITE_PLUGIN_REPO_SHALLOW_CLONE_RUN_ON_PULL_REQUESTS=false

  unset BUILDKITE_PLUGIN_REPO_SHALLOW_CLONE_DEPTH
  unset BUILDKITE_GIT_CLONE_FLAGS
  
  run "$PWD/hooks/pre-checkout"

  assert_success
}

@test "Set correctly the depth passed" {

  export BUILDKITE_PULL_REQUEST=false
  export BUILDKITE_PLUGIN_REPO_SHALLOW_CLONE_RUN_ON_PULL_REQUESTS=false
  export BUILDKITE_PLUGIN_REPO_SHALLOW_CLONE_DEPTH=3
  
  run "$PWD/hooks/pre-checkout"

  assert_success
  assert_output "Correctly set the values of the git clone flags to -v --depth 3"
}