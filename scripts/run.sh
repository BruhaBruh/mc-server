#!/bin/bash

. "/scripts/utilities.sh"

INITIAL_MEMORY=${INITIAL_MEMORY:-$JAVA_MEMORY}
MAXIMUM_MEMORY=${MAXIMUM_MEMORY:-$JAVA_MEMORY}

log "Start $SERVER server"
tail -f /mcsocket | java -Xms$INITIAL_MEMORY -Xmx$MAXIMUM_MEMORY $JAVA_FLAGS -jar $SERVER_CORE