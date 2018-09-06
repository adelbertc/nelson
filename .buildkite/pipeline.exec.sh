#!/usr/bin/env bash

git config --global user.email "team@getnelson.io"
git config --global user.name "Nelson Team"

# configure docker to use the remote tcp endpoint
export DOCKER_HOST="tcp://0.0.0.0:2375"

# subvert the sbt-rig plugin
export TRAVIS="true" # way hacky
export TRAVIS_COMMIT="$BUILDKITE_COMMIT"
export TRAVIS_REPO_SLUG="getnelson/nelson"
export TRAVIS_JOB_NUMBER="1.1"
export TRAVIS_BUILD_NUMBER="$BUILDKITE_BUILD_NUMBER"

if [ "$BUILDKITE_PULL_REQUEST" = 'false' ]; then
	git checkout -qf "$BUILDKITE_BRANCH";
fi

sbt ++2.11.11 'release with-defaults'
