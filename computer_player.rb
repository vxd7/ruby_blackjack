# frozen_string_literal: true

class ComputerPlayer < Player
  DECISION_HAND_VALUE = 17
  MAX_CARD_NUMBER = 3
  def initialize(bank)
    super('ComputerPlayer', bank)
  end

  def calculate_move
    if hand.hand_value >= DECISION_HAND_VALUE || hand.number_cards == MAX_CARD_NUMBER
      move_skip
    else
      move_add_card
    end
  end
end
