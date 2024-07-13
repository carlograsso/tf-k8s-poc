#!/bin/bash

ACTION=$1  #Terraform action to perform
IDENTIFIER=$2 #Cluster Names that must match the tfvars file and will match the workspace name.

WORKSPACES=$(terraform workspace show)

checkvarsfile() {
  if [ ! -f ./clusters/$1.tfvars ]; then
    echo "File ./clusters/$1.tfvars does not exist"
    exit 1
  else
    return 0
  fi
}

if checkvarsfile $IDENTIFIER; then
  if echo $WORKSPACES | grep -Fxq $IDENTIFIER; then
    terraform workspace select $IDENTIFIER
    echo "The workspace exists, selected $IDENTIFIER"
  else
    terraform workspace new $IDENTIFIER
    terraform workspace select $IDENTIFIER
    echo "The workspace have been created, selected $IDENTIFIER"
  fi
fi

ACTIVE_WORKSPACE=$(terraform workspace show)

if [[ $ACTIVE_WORKSPACE == $IDENTIFIER ]]; then
  echo "Operating on workspace $ACTIVE_WORKSPACE"
  terraform $ACTION -var-file=./clusters/$IDENTIFIER.tfvars
fi

