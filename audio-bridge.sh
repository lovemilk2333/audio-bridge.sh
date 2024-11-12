#!/usr/bin/env bash
# This is free and unencumbered software released into the public domain.

cmd_name="audio-bridge.sh"
version="v1"

function CreateSource {
    local dev_name="audio-bridge"

    pactl load-module module-null-sink \
        media.class=Audio/Source/Virtual sink_name="$dev_name" \
        channel_map=front-left,front-right
}

case "$1" in
create)
    CreateSource || exit $?
    echo "use this command to delete devices:"
    echo "pactl unload-module <ID>"
    ;;
version | --version | -v)
    echo "$cmd_name $version"
    ;;
help | --help | -h | *)
    echo "Usage: $cmd_name <Action>"
    echo "Action:"
    echo -e "    create\t\tCreate a bridge devices via pactl"
    echo -e "    version\t\tShow script version, compatible --version and -v"
    echo -e "    help(default)\tShow this help message, compatible --help and -h"
    ;;
esac
