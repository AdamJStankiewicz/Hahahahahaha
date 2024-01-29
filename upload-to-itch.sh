#!/bin/bash

# exit script early on failure
set -e

GAME=xanthus/kings-request
FILETITLE=haha

if [ -n "$1" ]
then
    echo usage: "$0"
    echo
    echo "Upload all builds to Itch.io"
    echo
    echo "Step 1: Configure the Itch.io butler tool."
    echo "         -> https://itch.io/docs/butler/"
    echo "Step 2: Export-all within Godot editor."
    echo "         -> Project -> Export -> Export All -> Release"
    echo "Step 3: Run this script."
    echo "         -> $0"
    echo
    echo "Don't run this script if you just want to upload one build."
    echo 'Instead, run `butler push builds/$TAG/ '$GAME':$TAG`,'
    echo 'where $TAG is web, linux64, or win64.'
    echo
    echo 'For Mac, run `butler push builds/macos/'"$FILETITLE"'.zip '$GAME':macos`.'
    exit 1
fi

for TAG in web linux64 win64
do
    butler push builds/$TAG/ $GAME:$TAG --ignore .gitkeep
done

# MacOS is special because Godot insists on exporting it as a zip.
# Fortunately, butler processes zips as a folder of their contents.
TAG=macos
butler push builds/$TAG/"$FILETITLE".zip $GAME:$TAG
