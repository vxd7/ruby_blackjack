# frozen_string_literal: true

require_relative 'card'

class PokerDeck
  def initialize
    @deck = []
    Card::COLORS.each { |r| Card::SUITS.each { |s| @deck << Card.new(s, r) } }
    @deck.shuffle!
  end

  def deal(num)
    @deck.shift(num)
  end
end
