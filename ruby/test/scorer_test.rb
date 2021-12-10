# frozen_string_literal: true

require "minitest/autorun"
require "minitest/color"
require_relative "../lib/scorer"

class ScorerTest < MiniTest::Test
  def setup
    @scorer = Scorer.new
  end

  def test_yellow_is_worth_1
    assert @scorer.tally(one: "Y", six: "YY") == { one: 1, six: 6 }
  end
end
