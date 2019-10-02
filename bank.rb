# frozen_string_literal: true

class Bank
  def initialize(*players, sum)
    raise ValueError, 'No players specified' if players.empty?
    raise ValueError, 'Invalid initial player bank' if sum <= 0

    @player_banks = {}
    @sum_bets = 0
    players.each { |player| @player_banks[player] = sum }
  end

  def make_bet(player, bet)
    raise ValueError, 'No such player' unless @player_banks.include?(player)

    @player_banks[player] -= bet
    @sum_bets += bet
  end

  def reward_winner(player)
    raise ValueError, 'No such player' unless @player_banks.include?(player)

    @player_banks[player] += @sum_bets
    @sum_bets = 0
  end
end
