require 'rails_helper'

describe Player do
  context 'attributes' do
    subject { Player.new(Board.new(3), SecureRandom.hex) }

    it 'has a board and api_key' do
      expect(subject.board.class).to eq(Board)
      expect(subject.api_key.class).to eq(String)
    end
  end
end
