# frozen_string_literal: true

require_relative 'blackjack_game'

class BlackjackTui
  MOVES = ['Skip move', 'Add card', 'Open cards'].freeze

  def initialize
    @player_name = start_game
    @blackjack_game = BlackjackGame(self, @player_name)
    @blackjack_game.new_game
  end

  def start_game
    puts '----- Welcome to the BlackJack game -----'
    print 'Please input your name: '
    player_name = gets.chomp
    print '----------------------------------------'
    player_name
  end

  def comp_player_info
  end

  def game_move(player)
    puts '----- Your turn -----'
    puts "> Your cards: #{player.hand}"
    puts "> Your points: #{player.hand_value}"
    puts "> Your money: #{player.money_in_bank}"
    puts ''
    puts 'Possible moves:'
    MOVES.each_with_index { |val, index| puts "#{index}. #{val}" }

    print 'Your choise: '
    player_action = gets.chomp

    act_name = player.ACTIONS[player_action]
    player.call("move_#{act_name}")
  end

end
