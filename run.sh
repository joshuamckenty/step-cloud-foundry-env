main() {
  set -e;

  # Assign global variables to local

  local appname="$WERCKER_CLOUD_FOUNDRY_DEPLOY_APPNAME"
  local alt_appname="$WERCKER_CLOUD_FOUNDRY_DEPLOY_ALT_APPNAME"
  local username="$WERCKER_CLOUD_FOUNDRY_DEPLOY_USERNAME"
  local password="$WERCKER_CLOUD_FOUNDRY_DEPLOY_PASSWORD"
  local organization="$WERCKER_CLOUD_FOUNDRY_DEPLOY_ORGANIZATION"
  local space="$WERCKER_CLOUD_FOUNDRY_DEPLOY_SPACE"
  local domain="$WERCKER_CLOUD_FOUNDRY_DEPLOY_DOMAIN"
  local hostname="$WERCKER_CLOUD_FOUNDRY_DEPLOY_HOSTNAME"
  local api="$WERCKER_CLOUD_FOUNDRY_DEPLOY_API"
  local skip_ssl="$WERCKER_CLOUD_FOUNDRY_DEPLOY_SKIP_SSL"
  local key="$WERCKER_CLOUD_FOUNDRY_ENV_KEYNAME"

  # Validate variables
  if [ -z "$appname" ] || [ -z "$username" ] || [ -z "$password" ] || [ -z "$organization" ] || [ -z "$space" ] ; then
    fail "appname, username, password, organization and space are required; please add them to the step";
  fi

  if [ -z "$api" ]; then
    api="https://api.run.pivotal.io";
    info "api not specified; using https://api.run.pivotal.io";
  fi

  info "Downloading CF CLI";
  wget -O cf.tgz "https://cli.run.pivotal.io/stable?release=linux64-binary";
  tar -zxf cf.tgz;

  info "Logging in to CF API";
  local login_cmd="./cf login \
      -u \"$username\" \
      -p \"$password\" \
      -o \"$organization\" \
      -s \"$space\" \
      -a \"$api\"";

  if [ -n "$skip_ssl" ]; then
    login_cmd="$login_cmd --skip-ssl-validation";
  fi
  eval $login_cmd;

  ./cf set-env $appname $key ${!key}
  if [ -n "$alt_appname" ]; then
    ./cf set-env $alt_appname $key ${!key}
  fi
}

# Run the main function
main;

