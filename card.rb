# frozen_string_literal: true

class Card
  SUITS = ['clubs', 'diamonds', 'hearts', 'spades'].freeze
  COLORS = ['ace',
            *(2..10).to_a,
            'jack', 'queen', 'king'].flatten.freeze
  attr_reader :suit, :color

  def initialize(suit, color)
    raise ValueError, 'Incorrect card suit' unless SUITS.include?(suit)
    raise ValueError, 'Incorrect card color' unless COLORS.include?(color)

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

  private

  def card_points(color, hand_sum)
    if color.is_a?(Integer)
      raise ValueError, 'Incorrect card color' if color < 2 || color > 10
    end

    return 10 if ['jack', 'queen', 'king'].include?(color)

    return color if color.is_a?(Integer)

    # If ace
    (11 if hand_sum + 11 <= 21) || 1
  end

  def card_to_str(suit, color)
    unicode_suits = { 'spades': '♠', 'hearts': '♥',
                      'diamonds': '♦', 'clubs': '♣' }
    colors_abbrev = { 'ace': 'A', 'jack': 'J', 'queen': 'Q', 'king': 'K' }
    encoded_suit = unicode_suits[suit.to_sym]

    return "#{color}#{encoded_suit}" if color.is_a?(Integer)

    "#{colors_abbrev[color.to_sym]}#{encoded_suit}"
  end
end
