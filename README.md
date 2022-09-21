# Bitbucket Pipelines Pipe: Azure CLI Deploy

A pipe to authenticate to Azure and run ad-hoc commands using the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/)

Note: This pipe was forked from https://bitbucket.org/microsoft/azure-cli-run for future maintenance purposes.

## YAML Definition

Add the following snippet to the script section of your `bitbucket-pipelines.yml` file:

```yaml
script:
  - pipe: atlassian/azure-cli-run:1.1.0
    variables:
      AZURE_APP_ID: $AZURE_APP_ID
      AZURE_PASSWORD: $AZURE_PASSWORD
      AZURE_TENANT_ID: $AZURE_TENANT_ID
      CLI_COMMAND: 'az $CLI_COMMAND'
      # DEBUG: DEBUG # Optional
```

## Variables

| Variable             | Usage                                                                                       |
|----------------------|---------------------------------------------------------------------------------------------|
| AZURE_APP_ID (*)     | The app ID, URL or name associated with the service principal required for login.           |
| AZURE_PASSWORD (*)   | Credentials like the service principal password, or path to certificate required for login. |
| AZURE_TENANT_ID  (*) | The AAD tenant required for login with the service principal.                               |
| CLI_COMMAND          | A string representing the Azure cli command                                                 |
| DEBUG                | Turn on extra debug information. Default: `false`.                                          |

_(*) = required variable._

## Prerequisites

You will need to configure a service principal with access to the resource you'd like to interact with.

### Documentation

* [Create an Azure service principal with Azure CLI](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli)

### Instructions

Create a service principal in your Azure subscription:

```sh
az ad sp create-for-rbac --name MyServicePrincipal
```

## Examples

Basic example:

```yaml
script:
  - pipe: atlassian/azure-cli-run:1.1.0
    variables:
      AZURE_APP_ID: $AZURE_APP_ID
      AZURE_PASSWORD: $AZURE_PASSWORD
      AZURE_TENANT_ID: $AZURE_TENANT_ID
      CLI_COMMAND: 'az account show'
```

Advanced example:

```yaml
script:
  - pipe: atlassian/azure-cli-run:1.1.0
    variables:
      AZURE_APP_ID: $AZURE_APP_ID
      AZURE_PASSWORD: $AZURE_PASSWORD
      AZURE_TENANT_ID: $AZURE_TENANT_ID
      CLI_COMMAND: 'az aks create --resource-group myResourceGroup --name myAKSCluster --node-count 1 --enable-addons monitoring --generate-ssh-keys'
      DEBUG: 'true'
```


## Support
If you’d like help with this pipe, or you have an issue or feature request, [let us know on Community][community].

If you’re reporting an issue, please include:

- the version of the pipe
- relevant logs and error messages
- steps to reproduce


## License
Copyright (c) 2020 Atlassian and others.
Apache 2.0 licensed, see [LICENSE](LICENSE.txt) file.


[community]: https://community.atlassian.com/t5/forums/postpage/board-id/bitbucket-questions?add-tags=bitbucket-pipelines,pipes,azure,cli
