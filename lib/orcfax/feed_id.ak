use aiken/bytearray

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
