require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'validations' do
    it { should validate_presence_of :player_1 }
    it { should validate_presence_of :player_2 }
  end

  context 'attributes' do
    let(:player_1) { Player.new(Board.new(4), SecureRandom.hex) }
    let(:player_2) { Player.new(Board.new(4), SecureRandom.hex) }
    subject { Game.create!(player_1: player_1, player_2: player_2) }

    it 'has default values' do
      expect(subject.player_1.class).to eq(Player)
      expect(subject.player_2.class).to eq(Player)
      expect(subject.winner).to be_nil
      expect(subject.player_1_turns).to be_nil
      expect(subject.player_2_turns).to be_nil
      expect(subject.current_turn).to eq("player_1")
    end
  end
end
