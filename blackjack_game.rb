# frozen_string_literal: true

require_relative 'poker_deck'
require_relative 'bank'
require_relative 'player'
require_relative 'computer_player'

class BlackjackGame
  BLACKJACK_POINTS = 21
  PLAYER_MAX_CARDS = 3
  GAME_NOT_STARTED = :game_not_started
  GAME_STARTED = :game_started
  GAME_FINISHED = :game_finished
  attr_reader :human_player, :comp_player, :game_state
  attr_reader :comp_player_last_move

  def initialize(user_interface, player_name = 'HumanPlayer')
    @deck = PokerDeck.new
    @bank = Bank.new
    @human_player = Player.new(player_name, @bank)
    @comp_player = ComputerPlayer.new(@bank)

    @user_interface = user_interface

    @bank.register_player(@human_player)
    @bank.register_player(@comp_player)

    @game_state = GAME_NOT_STARTED
  end

  def new_game
    unless @game_state == GAME_NOT_STARTED
      raise 'New game cannot be started! Wrong gamestate!'
    end

    @game_state = GAME_STARTED
    start_game
  end

  def continue_game
    unless @game_state == GAME_FINISHED
      raise 'Cannot continue finished game! Wrong gamestate'
    end

    @game_state = GAME_STARTED
    @deck = PokerDeck.new
    start_game
  end

  def game_move(player)
    if player.is_a?(ComputerPlayer)
      action = player.calculate_move
      @comp_player_last_move = action
    else
      action = @user_interface.game_move(player)
    end
    return if action == :skip

    send("action_#{action}", player)
  rescue StandardError
    retry
  end

  def comp_player_cards
    @comp_player.hand.number_cards
  end

  private

  def action_add_card(player)
    if player.hand.number_cards == PLAYER_MAX_CARDS
      raise 'Cannot add card! Player already has 3 cards'
    end

    player.hand.take_card(@deck.deal(1))
  end

  def action_open_cards(_player)
    @game_state = GAME_FINISHED
    finish_game
  end

  def check_fin_condition
    (@human_player.hand.number_cards == PLAYER_MAX_CARDS) &&
      (@comp_player.hand.number_cards == PLAYER_MAX_CARDS)
  end

  def finish_game
    # Open cards and finish game
    @game_state = GAME_FINISHED

    player_hand = @human_player.hand.cards
    comp_player_hand = @comp_player.hand.cards

    # Check bank and reward winner
    game_winner = winner
    if game_winner == :draw
      @bank.send(:draw)
    else
      @bank.send(:reward_winner, game_winner)
    end

    # Finally finish everything in UI
    @user_interface.finish_game(player_hand, @human_player.hand.hand_value,
                                comp_player_hand, @comp_player.hand.hand_value,
                                game_winner)
  end

  def winner
    player_hand_value = @human_player.hand.hand_value
    comp_player_hand_value = @comp_player.hand.hand_value

    return :draw if player_hand_value == comp_player_hand_value

    return @comp_player if player_hand_value > BLACKJACK_POINTS
    return @human_player if comp_player_hand_value > BLACKJACK_POINTS

    return @human_player if BLACKJACK_POINTS - player_hand_value < BLACKJACK_POINTS - comp_player_hand_value

    @comp_player
  end

  def start_game
    # Deal cards
    @human_player.new_hand(@deck.deal(2))
    @comp_player.new_hand(@deck.deal(2))

    # Make auto bets
    @bank.make_bet(human_player)
    @bank.make_bet(comp_player)

    loop do
      game_move(@human_player)
      game_move(@comp_player)

      break if check_fin_condition
    end

    finish_game
  end
end
