require 'rails_helper'

describe TurnProcessor do
  let(:board) { double ('board') }
  let(:player_1) { Player.new(board, 'setnd') }
  let(:player_2) { Player.new(board, 'setndarst') }

  let(:game) { Game.new(player_1: player_1, player_2: player_2)}

  subject { TurnProcessor.new(game, "A4", board, player_1)}

  it "exists when provided a game, target, board and player" do
    expect(subject).to be_a TurnProcessor
  end
end
