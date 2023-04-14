#!/bin/sh
set -e

source /app-info.sh

env_var_names=$(secretone env ls)
echo "The following environment variables will be populated with secrets from Secretone:"

echo "$env_var_names"
for var_name in $env_var_names; do
  secret_value=$(secretone env read $var_name)
  escaped_mask_value=$(echo "$secret_value" | sed -e 's/%/%25/g')
  IFS=$'\n'
  unset IFS
  if [ -n "${GITHUB_ENV}" ]; then
    random_heredoc_identifier=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n1)
    echo "$var_name<<${random_heredoc_identifier}" >> $GITHUB_ENV
    echo "$secret_value" >> $GITHUB_ENV
    echo "${random_heredoc_identifier}" >> $GITHUB_ENV
  else
    escaped_env_var_value=$(echo -n "$secret_value" | sed -z -e 's/%/%25/g' -e 's/\n/%0A/g')
    echo "::set-env name=$var_name::$escaped_env_var_value"
  fi
done
