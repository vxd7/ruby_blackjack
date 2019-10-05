# frozen_string_literal: true

class Hand
  def initialize(cards)
    raise 'Initially there can be only 2 cards on hand' if cards.length > 2

    @cards = cards
  end

  def take_card(card)
    @cards << card
  end

  def number_cards
    @cards.length
  end

  def hand_value
    overall_value = 0
    has_ace = false
    @cards.each do |card|
      has_ace = true if card.color == 'ace'
      overall_value += card.points(overall_value)
    end

    overall_value -= 10 if has_ace && overall_value > 21
    overall_value
  end
end
