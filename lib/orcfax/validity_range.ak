use aiken/interval.{Finite, Interval, IntervalBound}

/// `get_bounds` enforces that tx has a finite validity range. 
/// Any consumer must check that the `created_at` field of the Statement  
/// is relevant. Usually this will mean it is recent, say less than hour old for example. 
/// One way to ensure this would be to do something like 
/// ```
/// let Statement { feed_id, created_at, body } = dat.statement
/// let (lb, ub) = get_bounds(validity_range)
/// let thirty_minutes = 30 * 60 * 1000
/// expect and {
///     ub - lb < thirty_minutes,
///     lb - created_at < thirty_minutes,  
///   }
/// ```
pub fn get_bounds(validity_range: Interval) -> (Int, Int) {
  expect Interval {
    lower_bound: IntervalBound { bound_type: Finite(lb), .. },
    upper_bound: IntervalBound { bound_type: Finite(ub), .. },
  } = validity_range
  (lb, ub)
}
