#!/bin/bash

docker compose -f compose.prod.yml down

docker pull elixirprotocol/validator --platform linux/amd64

docker compose -f compose.prod.yml up -d
