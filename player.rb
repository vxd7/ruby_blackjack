# frozen_string_literal: true

require_relative 'hand'

class Player
  ACTIONS = [:skip, :add_card, :open_cards].freeze
  attr_reader :hand, :name

  def initialize(name, bank)
    @name = name
    @bank = bank
  end

  def new_hand(cards)
    @hand = Hand.new(cards)
  end

  def money_in_bank
    @bank.player_bank(self)
  end

  def bets_in_bank
    @bank.player_bet(self)
  end

  def move_skip
    ACTIONS[0]
  end

  def move_add_card
    ACTIONS[1]
  end

  def move_open_cards
    ACTIONS[2]
  end
end
