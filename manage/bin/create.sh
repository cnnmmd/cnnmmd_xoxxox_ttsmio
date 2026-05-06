#!/bin/bash

pthtop="$(cd "$(dirname "${0}")/../../../.." && pwd)"
source "${pthtop}"/manage/lib/params.sh
source "${pthtop}"/manage/lib/shared.sh
source "${pthcrr}"/params.sh

pthapp="${pthsrc}"/appmio
pthhgf="${pthapp}/hgf"
pthprm="${pthapp}/prm"
pthprj="${pthapp}/MioTTS-Inference"
cntapp='/opt/appmio'
cntprj="${cntapp}/MioTTS-Inference"

addimg ${imgtgt} "${cnfimg}" "${pthdoc}"
test -d "${pthapp}" || mkdir "${pthapp}"
test -d "${pthhgf}" || mkdir "${pthhgf}"
test -d "${pthprm}" || mkdir "${pthprm}"
if cd "${pthapp}"
then
  test -d "${pthprj}" || git clone --depth 1 https://github.com/Aratako/MioTTS-Inference.git
fi

docker run -v "${pthapp}":"${cntapp}" --name ${cnttgt} ${imgtgt} sh -c "cd ${cntprj} && /root/.local/bin/uv sync --python /env/python/bin/python" && \
docker commit ${cnttgt} ${imgtgt} && \
docker stop ${cnttgt} && \
docker rm ${cnttgt}
# && MAX_JOBS=8 /root/.local/bin/uv pip install --python /env/python/bin/python --no-build-isolation -v flash-attn
