#!/bin/bash

. "/scripts/utilities.sh"

log "Get paper version"
paperVersion=$(curl -Ls https://api.papermc.io/v2/projects/paper | jq --raw-output '[.versions[]] | last')
result=$?
if [ $result != 0 ]; then
  error "fail get paper version ($result)"
  exit 1
fi

log "Get paper $paperVersion build"
paperBuild=$(curl -Ls https://api.papermc.io/v2/projects/paper/versions/$paperVersion | jq --raw-output '[.builds[]] | last')
result=$?
if [ $result != 0 ]; then
  error "fail get paper $paperVersion build ($result)"
  exit 1
fi

log "Download paper ${paperVersion} build ${paperBuild}"
curl -Lso /data/server-core.jar https://api.papermc.io/v2/projects/paper/versions/${paperVersion}/builds/${paperBuild}/downloads/paper-${paperVersion}-${paperBuild}.jar
result=$?
if [ $result != 0 ]; then
  error "fail download paper ${paperVersion} build $paperBuild ($result)"
  exit 1
fi
