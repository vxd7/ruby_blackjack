# frozen_string_literal: true

class ComputerPlayer < Player
  def initialize(bank)
    send(:private, hand)

    super('ComputerPlayer', bank)
  end

  def calculate_move
    if hand_value >= 17
      move_skip
    else
      move_add_card
    end
  end
end
