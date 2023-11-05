#!/bin/bash

function isTrue() {
  case "${1,,}" in
  true | on | 1)
    return 0
    ;;
  *)
    return 1
    ;;
  esac
}

function isFalse() {
  case "${1,,}" in
  false | off | 0)
    return 0
    ;;
  *)
    return 1
    ;;
  esac
}

function isDebug() {
  if isTrue "${DEBUG:-false}"; then
    return 0
  else
    return 1
  fi
}

function debug() {
  if isDebugging; then
    log "DEBUG: $*"
  fi
}

function log() {
  local oldState
  # The  return  status  when listing options is zero if all optnames are enabled, non- zero otherwise.
  oldState=$(shopt -po xtrace || true)
  shopt -u -o xtrace

  if isDebug || isTrue "${LOG_TIMESTAMP:-false}"; then
    ts=" ($(date --rfc-3339=seconds))"
  else
    ts=
  fi
  echo "[log]${ts} $*"
  eval "$oldState"
}

function error() {
  local oldState
  # The  return  status  when listing options is zero if all optnames are enabled, non- zero otherwise.
  oldState=$(shopt -po xtrace || true)
  shopt -u -o xtrace

  if isDebug || isTrue "${LOG_TIMESTAMP:-false}"; then
    ts=" ($(date --rfc-3339=seconds))"
  else
    ts=
  fi
  echo "[error]${ts} $*"
  eval "$oldState"
}
