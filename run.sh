#!/bin/bash

set -e

case "$1" in
  build_generator)
    docker build -t generator ./generator
    ;;

  run_generator)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" generator
    ;;

  create_local_data)
    mkdir -p local_data
    python3 generator/src/generate.py local_data
    ;;

  build_reporter)
    docker build -t reporter ./reporter
    ;;

  run_reporter)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" reporter
    ;;

  report_server)
    docker run --rm -p 8080:80 -v "$(pwd)/data:/usr/share/nginx/html:ro" nginx:alpine
    ;;

  structure)
    find . -not -path './.git/*' | sort | sed -e 's/[^-][^\/]*\//  /g' -e 's/^  //' -e 's/-/|/'
    ;;

  clear_data)
    rm -f data/*.csv data/*.html
    echo "data/ очищена"
    ;;

  inside_generator)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" --entrypoint ls generator -la /data
    ;;

  inside_reporter)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" --entrypoint ls reporter -la /data
    ;;

  *)
    echo "Usage: $0 {build_generator|run_generator|create_local_data|build_reporter|run_reporter|report_server|structure|clear_data|inside_generator|inside_reporter}"
    exit 1
    ;;
esac