# frozen_string_literal: true

class ComputerPlayer < Player
  DECISION_HAND_VALUE = 17
  MAX_CARD_NUMBER = 3
  def initialize(bank)
    super('ComputerPlayer', bank)
  end

  def calculate_move
    if hand_value >= DECISION_HAND_VALUE || number_cards == MAX_CARD_NUMBER
      move_skip
    else
      move_add_card
    end
  end

  private

  attr_reader :hand
end
