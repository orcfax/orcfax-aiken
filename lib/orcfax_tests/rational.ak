use aiken/cbor
use orcfax/rational.{Rational, RationalFsDat, RationalStatement, a_to_b, b_to_a}
use orcfax/types as t

/// Demos of using feed statements
pub fn d00_demos() {
  0
}

/// Suppose one ada is 0.475$. 
/// As a rational, 0.475 = 19 / 40 
/// Lets convert some ada amounts into their equivalent values in usd
/// 
/// ```aiken
///  let ada_to_usd = Rational { num : 19 , denom : 40 } 
///  let a2b = a_to_b(ada_to_usd, _) 
///  and {
///    475 == a2b(1000),
///    4750 == a2b(10000),
///    95000 == a2b(200000),
///  }
/// ```
pub fn d01_a_to_b() {
  let ada_to_usd = Rational { num: 19, denom: 40 }
  let a2b =
    a_to_b(ada_to_usd, _)
  and {
    475 == a2b(1000),
    4750 == a2b(10000),
    95000 == a2b(200000),
  }
}

test test_01() {
  d01_a_to_b()
}

/// Analogously, lets convert some usd amounts into their equivalent values in usd
/// ```aiken
///  let ada_to_usd = Rational { num : 19 , denom : 40 } 
///  let b2a = b_to_a(ada_to_usd, _) 
///  and {
///    1000 == b2a(475),
///    10000 == b2a(4750),
///    200000 == b2a(95000),
///  }
/// ```
pub fn d02_b_to_a() {
  let ada_to_usd = Rational { num: 19, denom: 40 }
  let b2a =
    b_to_a(ada_to_usd, _)
  and {
    1000 == b2a(475),
    10000 == b2a(4750),
    200000 == b2a(95000),
  }
}

test test_02() {
  d02_b_to_a()
}

/// Aiken rounds down
/// ```aiken
///   and {
///     (-1) / 2 == -1,
///     (1) / 2 == 0,
///   }
/// ```
/// Anticipate this when expecting equality
/// ```aiken
///  let ada_to_usd = Rational { num: 19, denom: 40 }
///  let a2b =
///    a_to_b(ada_to_usd, _)
///  let b2a =
///    b_to_a(ada_to_usd, _)
///  and {
///    47 == a2b(100),
///    47 == a2b(99),
///    46 == a2b(98),
///    98 == b2a(47),
///    96 == b2a(46),
///  }
/// ```
pub fn d03_round_down() {
  let ada_to_usd = Rational { num: 19, denom: 40 }
  let a2b =
    a_to_b(ada_to_usd, _)
  let b2a =
    b_to_a(ada_to_usd, _)
  and {
    47 == a2b(100),
    47 == a2b(99),
    46 == a2b(98),
    98 == b2a(47),
    96 == b2a(46),
  }
}

test test_03() {
  d03_round_down()
}

pub fn d04_example_0() {
  let statement: RationalStatement =
    t.Statement {
      feed_id: "feedID",
      created_at: 1713377742844,
      body: Rational { num: 122345, denom: 6 },
    }
  let context = ""
  let datum: RationalFsDat = t.FsDat { statement, context }
  cbor.serialise(datum)
}

test test_04() {
  let expected =
    #"d8799fd8799f466665656449441b0000018eed458ffcd8799f1a0001dde906ffff40ff"
  d04_example_0() == expected
}
