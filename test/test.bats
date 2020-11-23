#!/usr/bin/env bats

setup() {
  DOCKER_IMAGE=${DOCKER_IMAGE:="test/azure-cli-run"}

  echo "Building image..."
  run docker build -t ${DOCKER_IMAGE} .
}

teardown() {
    echo "Teardown happens after each test."
}

@test "Basic CLI command using [az account show]" {
    run docker run \
        -e AZURE_APP_ID=${AZURE_APP_ID} \
        -e AZURE_PASSWORD=${AZURE_PASSWORD} \
        -e AZURE_TENANT_ID=${AZURE_TENANT_ID} \
        -e CLI_COMMAND="az account show" \
        -v $(pwd):$(pwd) \
        -w $(pwd) \
        ${DOCKER_IMAGE}

    echo "Status: $status"
    echo "Output: $output"

    [ "$status" -eq 0 ]
}

