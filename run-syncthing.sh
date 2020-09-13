#!/usr/bin/env bash
set -euo pipefail


docker run -e STGUIADDRESS= --network=host -v /wherever/st-sync:/var/syncthing syncthing/syncthing:latest
