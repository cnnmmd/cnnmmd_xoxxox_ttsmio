#!/bin/bash

cd /opt/appmio/MioTTS-Inference
.venv/bin/python3 run_server.py --llm-base-url http://host.docker.internal:8000/v1
