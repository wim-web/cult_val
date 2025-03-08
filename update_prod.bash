#!/bin/bash

docker compose down

docker pull elixirprotocol/validator --platform linux/amd64

docker compose up -d
