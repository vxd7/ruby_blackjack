# frozen_string_literal: true

class Hand
  def initialize(cards)
    raise 'Initially there can be only 2 cards on hand' if cards.length > 2

    @cards = cards
  end

  def take_card(card)
    @cards << card
  end
end
