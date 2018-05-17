require 'rails_helper'

describe "Api::V1::Ships" do
  context 'POST /api/v1/games/:id/ships' do
    player_1 = Player.new(Board.new(4), 'laksfhdalsdk')
    player_2 = Player.new(Board.new(4), '2lak34jefmsjs')
    let(:game) { Game.create(player_1: player_1, player_2: player_2) }
    it "updates the contents of the spaces on the player board" do
      headers = {"X-API-Key" => game.player_1.api_key}
      ship_1_payload = {
        ship_size: 3,
        start_space: "A1",
        end_space: "A3"
      }

      post "/api/v1/games/#{game.id}/ships", params: ship_1_payload, headers: headers

    end
  end
end
