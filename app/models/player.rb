class Player
  attr_reader :board, :api_key
  attr_accessor :turns

  def initialize(board, api_key)
    @board = board
    @api_key = api_key
    @turns = 0
  end
end
