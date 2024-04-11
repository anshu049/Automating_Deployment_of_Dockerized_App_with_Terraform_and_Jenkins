#!/usr/bin/env bash
docker-compose -f docker-compose.yaml up --detach --remove-orphans
echo "success"
