#!/bin/bash

# Canvaskit is required for video player package
fvm flutter build web --web-renderer canvaskit
firebase deploy
echo "Deployed 🎉"
