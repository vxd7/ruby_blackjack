# frozen_string_literal: true

require_relative 'card_misc'

class Card
  include CardMisc
  attr_reader :suit, :color

  def initialize(suit, color)
    @suit = suit
    @color = color
  end

  def points(hand_sum)
    raise ValueError, 'Need to know the current card sum on hands' if hand_sum.nil?

    card_points(@color, hand_sum)
  end

  def to_s
    card_to_str(@suit, @color)
  end
end
