#!/usr/bin/env bash
#
# A pipe to authenticate to Azure and run commands using the Azure CLI
#
# Required globals:
#   AZURE_APP_ID
#   AZURE_PASSWORD
#   AZURE_TENANT_ID
#
# Optional globals:
#   DEBUG (default: "false")

source "$(dirname "$0")/common.sh"

info "Executing the pipe..."

enable_debug() {
  if [[ "${DEBUG}" == "true" ]]; then
    info "Enabling debug mode."
    set -x
  fi
}
enable_debug

# required parameters

# azure service principal
AZURE_APP_ID=${AZURE_APP_ID:?'AZURE_APP_ID environment variable missing and is required for service principal authentication via the CLI.'}
AZURE_PASSWORD=${AZURE_PASSWORD:?'AZURE_PASSWORD environment variable missing and is required for service principal authentication via the CLI.'}
AZURE_TENANT_ID=${AZURE_TENANT_ID:?'AZURE_TENANT_ID environment variable missing and is required for service principal authentication via the CLI.'}

# CLI parameters
CLI_COMMAND=${CLI_COMMAND}


# default parameters
DEBUG=${DEBUG:="false"}

# check for azure service principal environment variables
if [[ -z "${AZURE_APP_ID}" ]] || [[ -z "${AZURE_PASSWORD}" ]] || [[ -z "${AZURE_TENANT_ID}" ]]; then
  fail "AZURE_APP_ID, AZURE_PASSWORD, AZURE_TENANT_ID are missing, cannot authenticate to Azure"    
fi

# log in to the azure cli
info "log in the azure cli using service principal"
run az login --service-principal --username "${AZURE_APP_ID}" --password "${AZURE_PASSWORD}" --tenant "${AZURE_TENANT_ID}"
if [[ "${status}" != "0" ]]; then  
  fail "Error logging in using azure service principal!"
fi

if [[ -z ${CLI_COMMAND} ]]; then
  fail "No Azure CLI command supplied.  Please pass via CLI_COMMAND env var."
else
  run ${CLI_COMMAND}
fi

if [[ "${status}" == "0" ]]; then
  success "Success!"
else
  fail "Error!"
fi
