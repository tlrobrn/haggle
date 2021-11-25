local scorer = require"scorer"

describe("scorer", function ()
  it("scores Yellow as 1", function ()
    assert.are.same(scorer{one="Y", six="YY"}, {one=1, six=6})
  end)

  it("scores Blue as 2", function ()
    assert.are.same(
      scorer{two="B", four="BB"},
      {two=2, four=4}
    )
  end)

  it("scores Red as 3", function ()
    assert.are.same(
      scorer{three="R", twelve="RR", five="RB"},
      {three=3, twelve=12, five=5}
    )
  end)

  it("scores Orange as 4", function ()
    assert.are.same(
      scorer{six="BO", eight="BYO"},
      {six=6, eight=8}
    )
  end)

  it("scores White as 5", function ()
    assert.are.same(
      scorer{five="W", eleven="BWO"},
      {five=5, eleven=11}
    )
  end)

  it("scores white as 0 if more than 4 are in the hand", function ()
    assert.are.same(
      scorer{fifteen="WWW", two="WWWWY"},
      {fifteen=15, two=2}
    )
  end)

  it("only scores as many Orange cards as Blue cards", function ()
    assert.are.same(
      scorer{six="OOB"},
      {six=6}
    )
  end)

  it("subtracts 10 from every other player if a hand has 5 or more Blue cards", function ()
    assert.are.same(
      scorer{zero="BBBBB", one="BBBBBY", negativeNineteen="Y"},
      {zero=0, one=1, negativeNineteen=-19}
    )
  end)

  it("does not subtract 10 for a set of 5 Blues in other hands if it has 3 Red cards", function ()
    assert.are.same(
      scorer{zero="RRRY", two="BBBBBB", one="BBBBBY", thirtysix="RRRRRR"},
      {zero=0, two=2, one=1, thirtysix=36}
    )
  end)

  it("gives bonus for the most Yellow cards", function ()
    assert.are.same(
      scorer{twelve="YYY", two="YY"},
      {twelve=12, two=2}
    )
  end)

  it("eliminates players with 7 or more cards in a single color", function ()
    assert.are.same(
      scorer{oops="YYYYYYY"},
      {oops="ELIMINATED"}
    )
  end)

  it("awards 10 points for sets of 5 colors", function ()
    assert.are.same(
      scorer{twentyfive="YBROW", sixtyfive="YYBBRROOWW"},
      {twentyfive=25, sixtyfive=65}
    )
  end)

  it("doubles the score for pyramid hands", function ()
    assert.are.same(
      scorer{sixtyfour="YBBRRROOOO"},
      {sixtyfour=64}
    )
  end)

  it("doubles the value of Red for the hand with the most Red cards", function ()
    assert.are.same(
      scorer{five="BR", fourteen="BRR"},
      {five=5, fourteen=14}
    )
  end)

  it("does not double Red values if there is a tie for most red", function ()
    assert.are.same(
      scorer{three="R", five="YR"},
      {three=3, five=5}
    )
  end)

  it("doubles a White value for each set of 2 Yellow cards", function ()
    assert.are.same(
      scorer{twentyseven="YYYWW", two="YYWWWW"},
      {twentyseven=27, two=2}
    )
  end)

  it("quadruples an Orange value for each set of 3 Blue cards", function ()
    assert.are.same(
      scorer{twentyeight="BBBBOO"},
      {twentyeight=28}
    )
  end)

  it("does not score more than 13 cards", function ()
    assert.are.same(
      scorer{sixty="YYYYYYBBBBBBR"},
      {sixty=60}
    )
    assert.are_not.same(
      scorer{notSixtysix="YYYYYYBBBBBBRR"},
      {notSixtysix=66}
    )
  end)
end)