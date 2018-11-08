#!/bin/bash
set -e

for i in {1..20}; do
    if rostopic list | grep rosout >/dev/null; then
        echo "Connected to master, running '$@'..."
        exec "$@"
        exit 0
    else
        echo "Retrying... ${i}/20"
        sleep 1
    fi
done

exit 1
