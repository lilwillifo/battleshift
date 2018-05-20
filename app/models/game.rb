class Game < ApplicationRecord
  validates_presence_of :player_1, :player_2
  
  attr_accessor :messages

  enum current_turn: ["player_1", "player_2"]
  serialize :player_1
  serialize :player_2

  validates :player_1, presence: true
  validates :player_2, presence: true
end
