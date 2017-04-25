#!/usr/bin/env ash

if [ -z $DRY_RUN ]; then

  # Change owner of config file if necessary
  USER=$(whoami)
  FILE_USER=$(stat -c '%U' /heartbeat/heartbeat.yml)
  if [ "$FILE_USER" != "root" ] && [ "$FILE_USER" != "$USER" ]; then
      echo "Change heartbeat.yml file owner to $USER"
      chown $USER /heartbeat/heartbeat.yml
  fi

  # Change permissions of the config file
  chmod go-w /heartbeat/heartbeat.yml

  heartbeat -e -v -c /heartbeat/heartbeat.yml $@
fi
