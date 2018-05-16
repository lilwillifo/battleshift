# require 'rails_helper'
#
# describe "Api::V1::Ships" do
#   context 'POST /api/v1/games/:id/ships' do
#     let(:sm_ship) { Ship.new(2) }
#     let(:player_1) { Player.new(Board.new(4), 'laksfhdalsdk') }
#     let(:player_2) { Player.new(Board.new(4), '2lak34jefmsjs') }
#     let(:game)    {
#       Game.create(
#         player_1: player_1,
#         player_2: player_2
#       )
#     }
#     it "updates the contents of the spaces on the player board" do
#       ship_1_payload = {
#                           ship_size: 3,
#                           start_space: "A1",
#                           end_space: "A3"
#                         }.to_json
#
#       post "/api/v1/games/#{game.id}/ships", params: ship_1_payload, :headers => {'X-API-KEY' => player_1.api_key}
#
#       game = Game.last
#       game_response = JSON.parse(response.body, symbolize_names: true)
#       expected_message = "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."
#
#       expect(game_response[:id]).to eq(game.id)
#       expect(game_response[:message]).to eq expected_messages
#       expect(game.player_1.board.board.first.first.values.first.contents.class).to eq(Ship)
#     end
#   end
# end
