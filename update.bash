#!/bin/bash

docker compose down

docker pull elixirprotocol/validator:testnet --platform linux/amd64

docker compose up -d
