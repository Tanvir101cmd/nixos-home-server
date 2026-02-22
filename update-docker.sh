#!/usr/bin/env bash

BASE_DIR="$HOME/docker"

find "$BASE_DIR" -type f -name "docker-compose.yml" | while read -r file; do
    dir=$(dirname "$file")
    echo "-------------------------------------------"
    echo "Updating services in: $dir"
    echo "-------------------------------------------"
    cd "$dir" || continue
    docker compose pull 
    docker compose up -d
done

echo "All stacks are up to date!"
