#!/bin/bash

. "/scripts/utilities.sh"

log "Get folia version"
foliaVersion=$(curl -Ls https://api.papermc.io/v2/projects/folia | jq --raw-output '[.versions[]] | last')
result=$?
if [ $result != 0 ]; then
  error "fail get folia version ($result)"
  exit 1
fi

log "Get folia $foliaVersion build"
foliaBuild=$(curl -Ls https://api.papermc.io/v2/projects/folia/versions/$foliaVersion | jq --raw-output '[.builds[]] | last')
result=$?
if [ $result != 0 ]; then
  error "fail get folia $foliaVersion build ($result)"
  exit 1
fi

log "Download folia ${foliaVersion} build ${foliaBuild}"
curl -Lso /data/server-core.jar https://api.papermc.io/v2/projects/folia/versions/${foliaVersion}/builds/${foliaBuild}/downloads/folia-${foliaVersion}-${foliaBuild}.jar
result=$?
if [ $result != 0 ]; then
  error "fail download folia ${foliaVersion} build $foliaBuild ($result)"
  exit 1
fi
