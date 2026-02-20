use aiken/primitive/bytearray

/// Any consumer must check that the `feed_id` field of the Statement  
/// is as expected. Usually the relevant feed is hard coded into the 
/// validator script. 
/// Orcfax is reserving the possibility of using a _versioned_ feed id
/// in the Statement in future. 
/// The versioned feed id is the contenation of (`feed_id`, `/`, `version`, `/`)
/// Versioning concerns code upstream.
/// Orcfax guarantees that the feed id part will not change.
/// Note that the trailing slash prevents, say, `ADA-USDM` being a match for `ADA-USD`
pub fn starts_with(actual_id: ByteArray, expected_prefix: ByteArray) {
  ( actual_id |> bytearray.take(expected_prefix |> bytearray.length) ) == expected_prefix
}

pub fn mk_feed_id(feed_type: ByteArray, feed_name: ByteArray) {
  feed_type
    |> bytearray.concat("/")
    |> bytearray.concat(feed_name)
    |> bytearray.concat("/")
}

/// Less efficient but possibly clearer. 
pub fn is_expected(
  actual_id: ByteArray,
  expected_feed_type: ByteArray,
  expected_feed_name: ByteArray,
) {
  actual_id |> starts_with(mk_feed_id(expected_feed_type, expected_feed_name))
}

test test_mk_feed_id_a() {
  let feed_id = mk_feed_id("CER", "ADA-USD")
  feed_id == "CER/ADA-USD/"
}

test test_mk_feed_id_b() {
  let feed_id = mk_feed_id("CER", "ADA-USD")
  feed_id == #"4345522f4144412d5553442f"
}

test test_is_expected_a() {
  is_expected("CER/ADA-USD/", "CER", "ADA-USD")
}

test test_is_expected_b() {
  is_expected(#"4345522f4144412d5553442f", "CER", "ADA-USD")
}
