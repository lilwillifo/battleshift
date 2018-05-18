class Api::V1::Games::ShotsController < ApiController
  before_action :check_for_valid_player

  def create
    if incorrect_player?
      render status: 400, json: current_game, message: "Invalid move. It's your opponent's turn."
    elsif game_over?
      render status: 400, json: current_game, message: "Invalid move. Game over."
    else
      turn_processor = TurnProcessor.new(current_game, params[:shot][:target], current_player, current_opponent)

      turn_processor.run!
      render status: turn_processor.status, winner: turn_processor.winner, json: current_game, message: turn_processor.message
    end
  end

  private

  def incorrect_player?
    players[request.headers['X-API-KEY']] != current_game.current_turn
  end

  def game_over?
    !current_game.winner.nil?
  end
  
  def players
    {current_game.player_1.api_key => 'player_1',
      current_game.player_2.api_key => 'player_2'}
  end

  def check_for_valid_player
    unless players.keys.any? {|x| x.include?(request.headers['X-API-KEY']) }
      render status: 403, json: current_game, message: "Whoops, you're not a part of this game."
    end
  end
end
