#!/bin/bash

. "/scripts/utilities.sh"

log "Get purpur version"
purpurVersion=$(curl -Ls https://api.purpurmc.org/v2/purpur | jq --raw-output '[.versions[]] | last')
result=$?
if [ $result != 0 ]; then
  error "fail get purpur version ($result)"
  exit 1
fi

log "Get purpur $purpurVersion build"
purpurBuild=$(curl -Ls https://api.purpurmc.org/v2/purpur/$purpurVersion | jq --raw-output '.builds.latest')
result=$?
if [ $result != 0 ]; then
  error "fail get purpur $purpurVersion build ($result)"
  exit 1
fi

log "Download purpur ${purpurVersion} build ${purpurBuild}"
curl -Lso /data/server-core.jar https://api.purpurmc.org/v2/purpur/$purpurVersion/$purpurBuild/download
result=$?
if [ $result != 0 ]; then
  error "fail download purpur ${purpurVersion} build $purpurBuild ($result)"
  exit 1
fi
