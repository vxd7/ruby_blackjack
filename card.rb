# frozen_string_literal: true

class Card
  include CardMisc
  attr_reader :suit, :color, :points

  def initialize(suit, color)
    @suit = suit
    @color = color
    @points = card_points(@suit, @color)
  end

  def to_s; end
end
