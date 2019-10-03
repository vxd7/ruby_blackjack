# frozen_string_literal: true

module CardMisc
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    SUITS = ['clubs', 'diamonds', 'hearts', 'spades'].freeze
    COLORS = ['ace',
              *(2..10).to_a,
              'jack', 'queen', 'king'].flatten.freeze

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
end
