#!/bin/bash

cntprj="${1}"
cntprk="${2}"
pthloc='/root/.local'

cd "${cntprk}" && \
cp pyproject.toml pyproject_old.toml && \
sed -i 's/pytorch-cu128/pytorch-cpu/g' pyproject.toml && \
sed -i 's#https://download.pytorch.org/whl/cu128#https://download.pytorch.org/whl/cpu#g' pyproject.toml && \
cd "${cntprj}" && \
cp pyproject.toml pyproject_old.toml && \
sed -i "s#miocodec @ git+https://github.com/Aratako/MioCodec@main#miocodec @ file://${cntprk}#" pyproject.toml && \
${pthloc}/bin/uv lock --upgrade-package torch --upgrade-package torchaudio && \
${pthloc}/bin/uv sync && \
${pthloc}/bin/uv add aiohttp

#sed -i '/^dependencies = \[/a\    "torch",\n    "torchaudio",' pyproject.toml && \
#sed -i '$a\
#[tool.uv.sources]\
#torch = [{ index = "pytorch-cpu" }]\
#torchaudio = [{ index = "pytorch-cpu" }]\
#\
#[[tool.uv.index]]\
#name = "pytorch-cpu"\
#url = "https://download.pytorch.org/whl/cpu"\
#explicit = true\
#' pyproject.toml && \
