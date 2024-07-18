#!/usr/bin/env bash

cd /autoconfig

# Copy startup config to enable volume mounting
if [ ! -f ./config/config.yml ]
then
  echo "Copy startup config"
  mkdir -p ./config
  cp ./config.yml.example ./config/config.yml
else 
  echo "Startup config already exist"
fi

FLASK_CONFIG=production /usr/bin/env python3 main.py
