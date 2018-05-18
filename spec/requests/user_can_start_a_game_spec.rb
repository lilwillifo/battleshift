require 'rails_helper'

describe 'POST /api/v1/games' do

  context 'with two active players' do
    let(:user) { User.create!(name: 'Jimmy', email: 'jimmy@jimmyhouse.com', password: 'justjimmythings', apikey: SecureRandom.hex)}

    it 'starts a game with boards' do
      User.create!(name: 'Adam', email: 'adam@bballbois.com', password: 'adamadamadam', apikey: SecureRandom.hex).active!

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.apikey }
      email = {opponent_email: "adam@bballbois.com"}.to_json

      post "/api/v1/games", params: email, headers: headers

      actual  = JSON.parse(response.body, symbolize_names: true)
      expected = Game.last

      expect(response).to be_success
      expect(actual[:id]).to eq(expected.id)
      expect(actual[:current_turn]).to eq(expected.current_turn)
      expect(actual[:player_1_board][:rows].count).to eq(4)
      expect(actual[:player_2_board][:rows].count).to eq(4)
      expect(actual[:player_1_board][:rows][0][:name]).to eq("row_a")
      expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
      expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
      expect(actual[:player_1_board][:rows][3][:data][0][:status]).to eq("Not Attacked")
    end
  end

  context 'with one inactive player' do
    it 'returns a 400' do
      User.create!(name: 'Adam', email: 'adam@bballbois.com', password: 'adamadamadam', apikey: SecureRandom.hex)

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => user.apikey }
      email = {opponent_email: "adam@bballbois.com"}.to_json

      post "/api/v1/games", params: email, headers: headers

      actual  = JSON.parse(response.body, symbolize_names: true)
      expected = Game.last

      expect(response).to be_success
      expect(actual[:id]).to eq(expected.id)
      expect(actual[:current_turn]).to eq(expected.current_turn)
      expect(actual[:player_1_board][:rows].count).to eq(4)
      expect(actual[:player_2_board][:rows].count).to eq(4)
      expect(actual[:player_1_board][:rows][0][:name]).to eq("row_a")
      expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
      expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
      expect(actual[:player_1_board][:rows][3][:data][0][:status]).to eq("Not Attacked")

    end
  end
end
