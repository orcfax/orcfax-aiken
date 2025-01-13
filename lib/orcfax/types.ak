/// Fs script
/// The FsDat is the datum containing orcfax statements
pub type FsDat<t> {
  statement: Statement<t>,
  context: Context,
}

/// The statement is for consumers
pub type Statement<t> {
  feed_id: ByteArray,
  created_at: Int,
  body: t,
}

// Orcfax actually uses the following context
//
// ```aiken
// pub type Context {
//   collect_after: Int,
//   collector: ByteArray,
// }
// ```
// 
// As consumers don't need this, 
// we can ignore it by setting context to be Data.

/// The context is for the orcfax publish protocol
pub type Context =
  Data

// Note : 28 bytes
/// Fsp script
pub type PubKey =
  ByteArray

pub type FspDat =
  PubKey
