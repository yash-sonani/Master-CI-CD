#!/bin/bash
# Check if the Apache server is running
if sudo /opt/bitnami/ctlscript.sh status apache | grep -q "apache.*running"; then
  exit 0
else
  exit 1