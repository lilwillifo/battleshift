require 'rails_helper'

describe TurnProcessor do
  let(:board) { double('board') }
  let(:user) { create(:user, apikey: SecureRandom.hex) }
  let(:user_2) { create(:user, apikey: SecureRandom.hex) }
  let(:player_1) { Player.new(board, user.apikey) }
  let(:player_2) { Player.new(board, user_2.apikey) }

  let(:game) { Game.new(player_1: player_1, player_2: player_2)}

  subject { TurnProcessor.new(game, "A4", board, player_1)}

  it "exists when provided a game, target, board and player" do
    expect(subject).to be_a TurnProcessor
  end

  describe "instance_methods" do
    context "#run!" do
      it "does a turn" do
        expect(game.current_turn).to eq("player_1")

        allow_any_instance_of(Shooter).to receive(:fire!).and_return('Your shot resulted in a Miss')
        allow(board).to receive(:defeated?).and_return(false)

        subject.run!

        expect(game.current_turn).to eq("player_2")
        expect(subject.message).to eq('Your shot resulted in a Miss')
      end
    end
  end

end
