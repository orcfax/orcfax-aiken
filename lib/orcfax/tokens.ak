use aiken/primitive/bytearray

pub fn fs() {
  ""
}

pub fn auth_pref() -> ByteArray {
  #"000643b0"
}

pub fn vali_pref() -> ByteArray {
  #"000de140"
}

pub fn fsp_label() {
  ""
}

pub fn fsp_vali() {
  bytearray.concat(vali_pref(), fsp_label())
}

pub fn fsp_auth() {
  bytearray.concat(auth_pref(), fsp_label())
}
