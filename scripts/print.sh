#!/bin/bash

import "$@" "$(xdg-user-dir PICTURES)/screenshots/$(date '+%F_%H-%M-%S').png"
