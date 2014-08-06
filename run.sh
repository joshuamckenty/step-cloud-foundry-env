key=${WERCKER_CLOUD_FOUNDRY_ENV_KEYNAME}
appname=${WERCKER_CLOUD_FOUNDRY_ENV_APPNAME}
username=$WERCKER_CLOUD_FOUNDRY_DEPLOY_USERNAME
password=$WERCKER_CLOUD_FOUNDRY_DEPLOY_PASSWORD
organization=$WERCKER_CLOUD_FOUNDRY_DEPLOY_ORGANIZATION
space=${WERCKER_CLOUD_FOUNDRY_DEPLOY_SPACE-development}
cf login -u $username -p $password -o $organization -s $space
cf set-env $appname $key ${!key}
