class Api::V1::Games::ShotsController < ApiController
  def create
    if players[request.headers['X-API-KEY']] != current_game.current_turn
      render json: {status: 400}
    else
      turn_processor = TurnProcessor.new(current_game, params[:shot][:target], current_player, current_opponent)

      turn_processor.run!
      render json: current_game, message: turn_processor.message
    end
  end

  private

  def players
    {current_game.player_1.api_key => 'player_1',
      current_game.player_2.api_key => 'player_2'}
  end
end
