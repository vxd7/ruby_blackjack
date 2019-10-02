# frozen_string_literal: true

require_relative 'card'
require_relative 'card_misc'

class PokerDeck
  include CardMisc

  def initialize
    @deck = []
    RANKS.each { |r| SUITS.each { |s| @deck << Card.new(r, s) } }
    @deck.shuffle!
  end

  def deal(num)
    @deck.shift(num)
  end
end
