local function parseHand(handString)
  local cardCounts = {
    Y=0,
    B=0,
    R=0,
    O=0,
    W=0,
  }

  for color in handString:gmatch"." do
    cardCounts[color] = cardCounts[color] + 1
  end

  return cardCounts
end

local function otherHands(hands, player)
  local result = {}
  for p, hand in pairs(hands) do
    if p ~= player then
      result[p] = hand
    end
  end

  return result
end

local function sortByYellow(hands)
  local list = {}
  for name, hand in pairs(hands) do
    list[#list + 1] = {name, hand}
  end

  table.sort(list, function (a, b) return a[2].Y > b[2].Y end)

  return list
end

local function yellowBonusRecipient(hands)
  local recipient = nil
  local maxSeen = 0
  local sortedHands = sortByYellow(hands)

  for _, playerHand in ipairs(sortedHands) do
    local player, hand = table.unpack(playerHand)
    if maxSeen < hand.Y then
      recipient = player
      maxSeen = hand.Y
    elseif maxSeen == hand.Y then
      recipient = nil
      maxSeen = 0
    end
  end

  return recipient
end

local function isEliminated(hand)
  for _, count in pairs(hand) do
    if count >= 7 then
      return true
    end
  end

  return false
end

local function setBonus(hand)
  local sets = math.maxinteger
  for _, count in pairs(hand) do
    sets = math.min(sets, count)
  end

  return sets * 10
end

local function calculate(hands, player)
  local hand = hands[player]
  if isEliminated(hand) then
    return "ELIMINATED"
  end
  local whiteValue = hand.W > 3 and 0 or 5
  local orangeCardsToScore = math.min(hand.B, hand.O)
  local bluePenalties = 0
  for _, otherHand in pairs(otherHands(hands, player)) do
    if otherHand.B >= 5 then
      bluePenalties = bluePenalties + 1
    end
  end
  bluePenalties = math.max(0, bluePenalties - hand.R // 3 )
  local yellowBonus = player == yellowBonusRecipient(hands) and hand.Y * hand.Y or 0

  return (
    hand.Y
    + 2 * hand.B
    + 3 * hand.R
    + 4 * orangeCardsToScore
    + whiteValue * hand.W
    - 10 * bluePenalties
    + yellowBonus
    + setBonus(hand)
  )
end

local function parseHands(handStrings)
  local hands = {}
  for player, handString in pairs(handStrings) do
    hands[player] = parseHand(handString)
  end

  return hands
end

local function scorer(handStrings)
  local hands = parseHands(handStrings)
  local scores = {}

  for player, hand in pairs(hands) do
    scores[player] = calculate(hands, player)
  end

  return scores
end

return scorer