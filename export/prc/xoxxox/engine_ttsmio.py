import json
import aiohttp
from xoxxox.shared import Custom

#---------------------------------------------------------------------------

class TtsPrc():

  def __init__(self, config="xoxxox/config_ttsmic_000", **dicprm):
    diccnf = Custom.update(config, dicprm)
    self.adrsrv = "http://127.0.0.1:8001/v1/tts"

  def status(self, config="xoxxox/config_ttsmic_000", **dicprm):
    diccnf = Custom.update(config, dicprm)
    self.keyspk = diccnf["keyspk"]

  async def infere(self, txtreq):
    dicreq = {
      "text": txtreq,
      "reference": {
        "type": "preset",
        "preset_id": self.keyspk
      },
      "output": {
        "format": "wav"
      }
    }
    async with aiohttp.ClientSession() as s:
      async with s.post(
        self.adrsrv,
        json=dicreq,
        headers={"Content-Type": "application/json"},
      ) as r:
        if r.status == 200:
          datwav = await r.read()
        else:
          datwav = "".encode("utf-8")
    return datwav
