require 'rails_helper'

describe "Api::V1::Ships" do
  let(:board)    { double('board') }
  let(:user)     { create(:user, apikey: SecureRandom.hex) }
  let(:user_2)   { create(:user, apikey: SecureRandom.hex) }
  let(:player_1) { Player.new(Board.new(4), user.apikey) }
  let(:player_2) { Player.new(Board.new(4), user_2.apikey) }
  let(:game)     { Game.create(player_1: player_1, player_2: player_2) }

  context 'POST /api/v1/games/:id/ships' do
    it "updates the contents of the spaces on the player board" do
      headers = {"X-API-Key" => game.player_1.api_key}
      ship_1_payload = {
        ship_size: 3,
        start_space: "A1",
        end_space: "A3"
      }

      status = post "/api/v1/games/#{game.id}/ships", params: ship_1_payload, headers: headers

      expect(status).to eq(200)
      game_response = JSON.parse(response.body, symbolize_names: true)
      expect(game_response[:id]).to eq(game.id)
      expect(game_response[:message]).to include("Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.")

      game = Game.last
      space_a1 = game.player_1.board.board.first.first['A1'].contents
      expect(space_a1).to be_a(Ship)
    end
    it 'A user cant place a ship diagonally' do
      headers = {"X-API-Key" => game.player_1.api_key}
      ship_2_payload = {
        ship_size: 3,
        start_space: "A1",
        end_space: "B3"
      }

      expect{post "/api/v1/games/#{game.id}/ships", params: ship_2_payload, headers: headers}.to raise_error(InvalidShipPlacement)

      game = Game.last
      space_a1 = game.player_1.board.board.first.first['A1'].contents
      expect(space_a1).to eq(nil)
    end
  end
end
