#!/bin/bash

cntprj="${1}"
pthloc='/root/.local'

cd "${cntprj}" && \
cp pyproject.toml pyproject_old.toml && \
sed -i '/^dependencies = \[/a\    "torch",\n    "torchaudio",' pyproject.toml && \
sed -i '$a\
[tool.uv.sources]\
torch = [{ index = "pytorch-cpu" }]\
torchaudio = [{ index = "pytorch-cpu" }]\
\
[[tool.uv.index]]\
name = "pytorch-cpu"\
url = "https://download.pytorch.org/whl/cpu"\
explicit = true\
' pyproject.toml && \
${pthloc}/bin/uv lock --upgrade-package torch --upgrade-package torchaudio && \
${pthloc}/bin/uv sync && \
${pthloc}/bin/uv add aiohttp
