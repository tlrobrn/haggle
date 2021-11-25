local function parseHand(hand)
  local cardCounts = {
    Y=0,
    B=0,
    R=0,
    O=0,
    W=0,
  }
  for color in hand:gmatch"." do
    cardCounts[color] = cardCounts[color] + 1
  end

  return cardCounts
end

local function calculate(hand)
  return (
    hand.Y
    + 2 * hand.B
    + 3 * hand.R
    + 4 * hand.O
    + 5 * hand.W
  )
end

local function scorer(hands)
  local scores = {}

  for player, hand in pairs(hands) do
    scores[player] = calculate(parseHand(hand))
  end

  return scores
end

return scorer