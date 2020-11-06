#!/usr/bin/env bash
set -euo pipefail


docker run -e STGUIADDRESS= --network=host -v $HOME/Dropbox/onyx:/var/syncthing syncthing/syncthing:latest
