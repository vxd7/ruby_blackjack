# frozen_string_literal: true

require_relative 'blackjack_game'

class BlackjackTui
  MOVES = ['Skip move', 'Add card', 'Open cards'].freeze

  def start_game
    puts '----- Welcome to the BlackJack game -----'
    print 'Please input your name: '
    player_name = gets.chomp
    puts '----------------------------------------'
    @blackjack_game = BlackjackGame.new(self, player_name)
    @blackjack_game.new_game
  end

  def game_move(player)
    puts "!> Computer player last action was: #{comp_player_status}"
    print '!> Computer player cards:'
    @blackjack_game.comp_player_cards.times { print '* ' }
    puts ''
    puts '----------------------------------------'

    puts '----- Your turn -----'
    puts "> Your cards: #{hand_to_str(player.hand)}"
    puts "> Your points: #{player.hand_value}"
    puts "> Your money: #{player.money_in_bank}"
    puts ''
    puts 'Possible moves:'
    MOVES.each_with_index { |val, index| puts "#{index}. #{val}" }

    print 'Your choise: '
    player_action = gets.chomp

    act_name = player.class::ACTIONS[player_action.to_i]
    player.send("move_#{act_name}")

  rescue StandardError => e
    puts 'There was an error!'
    puts "The message was: #{e.message}"
    puts 'Try again'
    retry
  end

  def finish_game(player_hand, player_pts, comp_player_hand,
                  comp_player_pts, winner)
    puts '----------------------------------------'
    puts '!!! > Game finished < !!!'

    puts 'Its a draw!' if winner == :draw
    puts "Winner is: #{winner.name}" unless winner == :draw

    puts "Your cards: #{hand_to_str(player_hand)}; Your points: #{player_pts}"
    puts "ComputerPlayer cards: #{hand_to_str(comp_player_hand)}; Points: #{comp_player_pts}"
    puts '----------------------------------------'
    puts ''
    puts 'New game? [y/n]'
    new_game = gets.chomp

    @blackjack_game.continue_game if new_game == 'y'
    exit(0) if new_game == 'n'
  end

  private

  def hand_to_str(hand)
    res_str = ''
    hand.each { |card| res_str += card.to_s + ' ' }
    res_str
  end

  def comp_player_status
    @blackjack_game.comp_player_last_move
  end

end
