#!/usr/bin/env bash
set -e

HOST_DIR="$(pwd -W 2>/dev/null || pwd)"

if [ "$1" = "build_generator" ]; then
  docker build -t generator ./generator

elif [ "$1" = "run_generator" ]; then
  mkdir -p data
  MSYS_NO_PATHCONV=1 docker run --rm -v "$HOST_DIR/data:/data" generator

elif [ "$1" = "create_local_data" ]; then
  mkdir -p local_data
  python generator/generate.py local_data

elif [ "$1" = "build_reporter" ]; then
  docker build -t reporter ./reporter

elif [ "$1" = "run_reporter" ]; then
  mkdir -p data
  MSYS_NO_PATHCONV=1 docker run --rm -v "$HOST_DIR/data:/data" reporter

elif [ "$1" = "structure" ]; then
  find . -not -path './.git/*' | sort

elif [ "$1" = "clear_data" ]; then
  rm -f data/*.csv
  rm -f data/*.html

elif [ "$1" = "inside_generator" ]; then
  mkdir -p data
  MSYS_NO_PATHCONV=1 docker run --rm -v "$HOST_DIR/data:/data" --entrypoint ls generator -la /data

elif [ "$1" = "inside_reporter" ]; then
  mkdir -p data
  MSYS_NO_PATHCONV=1 docker run --rm -v "$HOST_DIR/data:/data" --entrypoint ls reporter -la /data

elif [ "$1" = "report_server" ]; then
  mkdir -p data
  MSYS_NO_PATHCONV=1 docker run --rm -p 8080:80 -v "$HOST_DIR/data:/usr/share/nginx/html:ro" nginx:alpine

else
  exit 1
fi