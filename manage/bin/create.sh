#!/bin/bash

pthtop="$(cd "$(dirname "${0}")/../../../.." && pwd)"
source "${pthtop}"/manage/lib/params.sh
source "${pthtop}"/manage/lib/shared.sh
source "${pthcrr}"/params.sh

pthapp="${pthsrc}"/appmio
pthhgf="${pthapp}/hgf"
pthprm="${pthapp}/prm"
pthprj="${pthapp}/MioTTS-Inference"
pthprk="${pthapp}/MioCodec"
cntapp='/opt/appmio'
cntprj="${cntapp}/MioTTS-Inference"
cntprk="${cntapp}/MioCodec"

addimg ${imgtgt} "${cnfimg}" "${pthdoc}"
test -d "${pthapp}" || mkdir "${pthapp}"
test -d "${pthhgf}" || mkdir "${pthhgf}"
test -d "${pthprm}" || mkdir "${pthprm}"
if cd "${pthapp}"
then
  test -d "${pthprj}" || git clone --depth 1 https://github.com/Aratako/MioTTS-Inference.git
  test -d "${pthprk}" || git clone --depth 1 https://github.com/Aratako/MioCodec
fi

docker run -v "${pthapp}":"${cntapp}" --name ${cnttgt} ${imgtgt} /exp/runcfg.sh "${cntprj}" "${cntprk}" && \
docker commit ${cnttgt} ${imgtgt} && \
docker stop ${cnttgt} && \
docker rm ${cnttgt}
# && MAX_JOBS=8 /root/.local/bin/uv pip install --python /env/python/bin/python --no-build-isolation -v flash-attn
