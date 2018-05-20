require 'rails_helper'

describe TurnProcessor do
  let(:board)    { double('board') }
  let(:user)     { create(:user, apikey: SecureRandom.hex) }
  let(:user_2)   { create(:user, apikey: SecureRandom.hex) }
  let(:player_1) { Player.new(board, user.apikey) }
  let(:player_2) { Player.new(board, user_2.apikey) }

  let(:game) { Game.new(player_1: player_1, player_2: player_2)}

  subject { TurnProcessor.new(game, "A4", player_1, player_2)}

  describe "class_methods" do
    context "initialize" do
      it "exists when provided a game, target, board and player" do
        expect(subject).to be_a TurnProcessor
      end
    end
  end

  describe "instance_methods" do
    context "#run!" do
      it "changes turns and sends a message" do
        expect(game.current_turn).to eq("player_1")

        allow_any_instance_of(Shooter).to receive(:fire!).and_return('Your shot resulted in a Miss')
        allow(board).to receive(:defeated?).and_return(false)

        subject.run!

        expect(game.current_turn).to eq("player_2")
        expect(subject.message).to eq('Your shot resulted in a Miss')
      end

      it "can assign a winner" do
        expect(game.current_turn).to eq("player_1")

        allow_any_instance_of(Shooter).to receive(:fire!).and_return("Battleship sunk.")
        allow(board).to receive(:defeated?).and_return(true)

        subject.run!
        expect(game.winner).to eq("#{user.email}")

        expect(subject.message).to eq("Battleship sunk. Game over.")
        expect(subject.status).to eq(200)
      end
    end
  end
end
