#!/bin/bash
#######################################
# Assuming aks.tf file containing
#   client_id     = "00000000-0000-0000-0000-000000000000"
#   client_secret = "00000000000000000000000000000000"
# Creates .bk copy of original, then Service Principal
# and creates new aks.tf with the id and secret 
#######################################

error()
{
  [[ -n "$@" ]] && echo "ERROR: $@" >&2
}

zero_id="00000000-0000-0000-0000-000000000000"
zero_secret="00000000000000000000000000000000"

# Needs jq - installed by default on Azure Terraform marketplace offering
jq --version >/dev/null || error "jq not found"

# Check file exists
filename=aks.tf
[[ ! -f $filename ]] && error "$filename not found."

# Check file contains the zeroed properties
if [[ $(grep -Ec "$zero_id|$zero_secret" $filename) -ne 2 ]] 
then error "Zeroed client_id and client_secret not found"
fi

# Backup original
cp -p $filename ${filename%.tf}.bk || error "Could not backup to ${filename%.tf}.bk"
echo "Backup file ${filename%.tf}.bk created." 

# Create Service Principal
echo "az ad sp create-for-rbac --skip-assignment" 
spout=$(az ad sp create-for-rbac --skip-assignment --output json)
jq . <<< $spout 

# Set the variables
id=$(jq -r .appId <<< $spout)
secret=$(jq -r .password <<< $spout)

# Recreate the file
sed -e "s/$zero_id/$id/1" -e "s/$zero_secret/$secret/1" ${filename%.tf}.bk > $filename

echo "Successfully recreated $filename" 
