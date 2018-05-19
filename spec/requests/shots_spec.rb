require 'rails_helper'

describe "Api::V1::Shots" do
  context "POST /api/v1/games/:id/shots" do
    let(:user) { create(:user, apikey: SecureRandom.hex) }
    let(:user_2) { create(:user, apikey: SecureRandom.hex) }
    let(:player_1)   { Player.new(Board.new(4), user.apikey)}
    let(:player_2)   { Player.new(Board.new(4), user_2.apikey) }
    let(:sm_ship) { Ship.new(2) }
    let(:game)  {
      create(:game,
        player_1: player_1,
        player_2: player_2
      )
    }

    it "updates the message and board with a hit" do
      ShipPlacer.new(board: player_2.board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2").run

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player_1.api_key }
      json_payload = {target: "A1"}.to_json


      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Hit"
      player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]


      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Hit")
    end

    it "updates the message and board with a miss" do
      ShipPlacer.new(board: player_2.board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2").run

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player_1.api_key }
      json_payload = {target: "A4"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Miss"
      player_2_targeted_space = game[:player_2_board][:rows].first[:data].last[:status]


      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Miss")
    end

    it "updates the message but not the board with invalid coordinates" do
      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player_1.api_key }
      json_payload = {target: "D15"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers
      game = JSON.parse(response.body, symbolize_names: true)
      expect(game[:message]).to eq "Invalid coordinates."
    end

    it "won't let another player join the game" do
      player_3 = User.create!(name: "Scorpion King", email: 'pointy@ow.com', password: 'hsssss', apikey: SecureRandom.hex)
      ShipPlacer.new(board: player_2.board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2").run

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player_3.apikey }
      json_payload = {target: "A1"}.to_json


      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      game = JSON.parse(response.body, symbolize_names: true)
      expect(game[:message]).to eq "Unauthorized"
    end

    it "won't let another player move if it's not their turn" do
      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player_2.api_key }
      json_payload = {target: "B2"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers
      game = JSON.parse(response.body, symbolize_names: true)
      expect(game[:message]).to eq "Invalid move. It's your opponent's turn."
    end

  end
end
