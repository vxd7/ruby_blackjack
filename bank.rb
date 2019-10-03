# frozen_string_literal: true

class Bank
  def initialize
    @player_banks = {}
    @player_bets = {}
  end

  def register_player(player, sum)
    raise ValueError, 'Invalid initial player bank' if sum <= 0

    @player_banks[player] = sum
    @player_bets[player] = 0
  end

  def make_bet(player, bet)
    raise ValueError, 'No such player' unless @player_banks.include?(player)

    @player_banks[player] -= bet
    @player_bets[player] += bet
  end

  def player_bank(player)
    raise ValueError, 'No such player' unless @player_banks.include?(player)

    @player_banks[player]
  end

  def player_bet(player)
    raise ValueError, 'No such player' unless @player_banks.include?(player)

    @player_bets[player]
  end

  def all_bets
    @player_bets.values.sum
  end

  private

  def reward_winner(player)
    raise ValueError, 'No such player' unless @player_banks.include?(player)

    @player_banks[player] += all_bets
    @player_bets.keys.each { |pl| @player_bets[pl] = 0 }
  end

  def draw
    @player_banks.keys.each do |player|
      @player_banks[player] += @player_bets[player]
      @player_bets[player] = 0
    end
  end
end
