local scorer = require"scorer"

describe("scorer", function ()
  it("scores Yellow as 1", function ()
    assert.are.same(scorer{one="Y", two="YY"}, {one=1, two=2})
  end)

  it("scores Blue as 2", function ()
    assert.are.same(
      scorer{two="B", three="BY", four="BB"},
      {two=2, three=3, four=4}
    )
  end)

  it("scores Red as 3", function ()
    assert.are.same(
      scorer{three="R", four="RY", five="RB"},
      {three=3, four=4, five=5}
    )
  end)

  it("scores Orange as 4", function ()
    assert.are.same(
      scorer{four="O", five="YO"},
      {four=4, five=5}
    )
  end)

  it("scores White as 5", function ()
    assert.are.same(
      scorer{five="W", nine="WO"},
      {five=5, nine=9}
    )
  end)

  it("scores white as 0 if more than 4 are in the hand", function ()
    assert.are.same(
      scorer{fifteen="WWW", one="WWWWY"},
      {fifteen=15, one=1}
    )
  end)
end)