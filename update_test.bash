#!/bin/bash

docker compose -f compose.test.yml down

docker pull elixirprotocol/validator:testnet --platform linux/amd64

docker compose -f compose.test.yml up -d
