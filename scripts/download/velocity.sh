#!/bin/bash

. "/scripts/utilities.sh"

log "Get velocity version"
velocityVersion=$(curl -Ls https://api.papermc.io/v2/projects/velocity | jq --raw-output '[.versions[]] | last')
result=$?
if [ $result != 0 ]; then
  error "fail get velocity version ($result)"
  exit 1
fi

log "Get velocity $velocityVersion build"
velocityBuild=$(curl -Ls https://api.papermc.io/v2/projects/velocity/versions/$velocityVersion | jq --raw-output '[.builds[]] | last')
result=$?
if [ $result != 0 ]; then
  error "fail get velocity $velocityVersion build ($result)"
  exit 1
fi

log "Download velocity ${velocityVersion} build ${velocityBuild}"
curl -Lso /data/server-core.jar https://api.papermc.io/v2/projects/velocity/versions/${velocityVersion}/builds/${velocityBuild}/downloads/velocity-${velocityVersion}-${velocityBuild}.jar
result=$?
if [ $result != 0 ]; then
  error "fail download velocity ${velocityVersion} build $velocityBuild ($result)"
  exit 1
fi