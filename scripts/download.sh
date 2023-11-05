#!/bin/bash

. "/scripts/utilities.sh"

if [ ! -f /data/$SERVER_CORE ]; then
  if [ $SERVER == "velocity" ]; then
    /scripts/download/velocity.sh
  elif [ $SERVER == "paper" ]; then
    /scripts/download/paper.sh
  elif [ $SERVER == "folia" ]; then
    /scripts/download/folia.sh
  elif [ $SERVER == "purpur" ]; then
    /scripts/download/purpur.sh
  else
    log "invalid server type. Valid types: velocity, paper, folia, purpur"
    exit 1
  fi
fi
