# Haggle Scorer

Implementation(s) of a [Haggle](https://boardgamegeek.com/boardgame/17529/haggle) scorer
for the [original ruleset](https://boardgamegeek.com/filepage/43164/haggle-rule-set-sid-sacksons-original-v10) defined by Sid Sackson.

## Requirements

Implement a Haggle scorer that can compute a score for each player given the cards each player submits. A player's score will either be an integer or "ELIMINATED".

### API

The program should take in arguments of the players names and their hands (as an string of abbreviated colors Y for Yellow, O for Orange, etc).

It should output an ordered list of the players with their scores (one per line)

For example, to score hands of

1. Yellow, Yellow, Red
2. Orange, White, Blue
3. White, Blue, Red, Orange
4. 7 White cards

the command would look like:

```sh
$ haggle Taylor=YYR Tyler=OWB OtherTaylor=WBRO Dummy=WWWWWWW
OtherTaylor: 14
Tyler: 11
Taylor: 5
Dummy: ELIMINATED
```

_(Totals in example may not be accurate according to all the rules listed below)_

## General Game Rules

These are the rules of the game. They are provided to give context for the scoring ruleset listed below, but they are not necessarily important for the implementation of the Haggle scorer.

### Components

- Enough scoring rules cards to give 2 unique rules to each player
- Enough color cards (e.g. `Yellow`, `Blue`, `Red`, etc.) to give each player 10

### Setup

1. Shuffle the scoring rules cards and give 2 to each player.
2. Shuffle all the color cards together and give 10 to each player.

### Gameplay

The players are given a set time limit (e.g. 20 minutes).
Within that time limit they may trade color cards, rules cards, and information (e.g. a peek at a rules card) freely amongst themselves.
At the end of the time limit, they will turn in their hand of color cards for scoring.
Hands are scored according to the _full ruleset_, not just the rules cards they have.

## Simplified Scoring Ruleset

The rules are re-defined here, with basic values explicitly defined for purposes of implementing a scorer.

### Basic Values

- `Yellow` cards are worth **1** point
- `Blue` cards are worth **2** points
- `Red` cards are worth **3** points
- `Orange` cards are worth **4** points
- `White` cards are worth **5** points

### Modifiers

1. If a player has more than 3 `White` cards, then their `White` cards are worth **0** points
2. A player can score only as many `Orange` cards as they have `Blue` cards
3. If a player has 5 or more `Blue` cards, then **10** points are deducted from _every other_ player
4. A set of 3 `Red` cards protects a player from one set of `Blue` cards (see #3)
5. The player with the most `Yellow` cards gets a bonus of those cards squared
   - If there is a tie for most `Yellow` cards, then the _next most_ number of `Yellow` cards earns the bonus instead
6. If a player hands in 7 or more cards of the same color, they are **ELIMINATED**
7. Each set of 5 different colors gives a bonus of **10** points
8. If a `pyramid` is handed in with _no other cards_, the value of the hand is doubled
   - A `pyramid` consists of 4 cards of one color, 3 cards of a second color, 2 cards of a 3rd color, and 1 card of a fourth color
9. The player with the most `Red` cards double their value.
   - If there is a tie amongst the players, then no doubling occurs
10. Each set of 2 `Yellow` cards doubles the value of 1 `White` card
11. Each set of 3 `Blue` cards quadruples the value of 1 `Orange` card
12. No more than 13 cards in a hand can be scored
   - If more than 13 are handed in, the excess will be removed at random