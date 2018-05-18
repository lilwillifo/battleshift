class Api::V1::Games::ShotsController < ApiController
  def create
    if incorrect_player?
      render status: 400, json: current_game, message: "Invalid move. It's your opponent's turn."
    else
      turn_processor = TurnProcessor.new(current_game, params[:shot][:target], current_player, current_opponent)

      turn_processor.run!
      render status: turn_processor.status, json: current_game, message: turn_processor.message
    end
  end

  private

  def incorrect_player?
    players[request.headers['X-API-KEY']] != current_game.current_turn
  end

  def players
    {current_game.player_1.api_key => 'player_1',
      current_game.player_2.api_key => 'player_2'}
  end
end
