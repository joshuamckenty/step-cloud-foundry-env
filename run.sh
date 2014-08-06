key=${WERCKER_CLOUD_FOUNDRY_ENV_KEYNAME}
appname=${WERCKER_CLOUD_FOUNDRY_ENV_APPNAME}
cf set-env $appname $key ${!key}
