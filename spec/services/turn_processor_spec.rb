require 'rails_helper'

describe TurnProcessor do
  let(:board) { double('board') }
  let(:player_1) { Player.new(board, 'setnd') }
  let(:player_2) { Player.new(board, 'setndarst') }

  let(:game) { Game.new(player_1: player_1, player_2: player_2)}

  subject { TurnProcessor.new(game, "A4", board, player_1)}

  it "exists when provided a game, target, board and player" do
    expect(subject).to be_a TurnProcessor
  end

  describe "instance_methods" do
    context "#run!" do
      it "does a turn" do
        expect(game.current_turn).to eq("player_1")

        allow_any_instance_of(Shooter).to receive(:fire!).and_return('Miss')
        # allow_any_instance_of(Shooter).to receive(:message).and_return(nil)
        # board.should_receive(:space_names).and_return(["A1", "A2", "A3", "A4"])
        allow(board).to receive(:defeated?).and_return(false)
        subject.run!


        # allow(board).to receive(:space_names).and_return(["A1", "A2", "A3", "A4"])

        expect(game.current_turn).to eq("player_2")
      end
    end
  end

end
