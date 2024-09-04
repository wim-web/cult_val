#!/bin/bash

docker compose down

docker pull elixirprotocol/validator:v3 --platform linux/amd64

docker compose up -d
