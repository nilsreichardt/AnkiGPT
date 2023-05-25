#!/bin/bash

fvm flutter build web
firebase deploy
echo "Deployed 🎉"
