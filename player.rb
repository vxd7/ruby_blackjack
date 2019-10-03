# frozen_string_literal: true

class Player
  ACTIONS = [:skip, :add_card, :open_cards].freeze
  attr_reader :hand, :name

  def initialize(name, bank)
    @name = name
    @bank = bank
    @hand = []
  end

  def take_cards(cards)
    raise ValueError, 'Cannot take more than 2 cards' if cards.length > 2

    (@hand << cards).flatten!
  end

  def hand_value
    overall_value = 0
    @hand.each { |card| overall_value += card.points(overall_value) }
    overall_value
  end

  def empty_hand
    @hand = []
  end

  def number_cards
    @hand.length
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
