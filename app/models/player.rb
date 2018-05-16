class Player
  attr_reader :board, :api_key

  def initialize(board, api_key)
    @board = board
    @api_key = api_key
  end
end
