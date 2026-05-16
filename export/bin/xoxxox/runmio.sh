#!/bin/bash

adrllm="${1}"

cd /opt/appmio/MioTTS-Inference
.venv/bin/python3 run_server.py --llm-base-url "${adrllm}"
