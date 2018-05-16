class ApiController < ActionController::API

  def current_game
    game_id = params[:game_id] || params[:id]
    @game ||= Game.find(game_id)
  end

  def current_player
    if request.headers['X-API-KEY'] == current_game.player_1.api_key
      current_game.player_1
    elsif request.headers['X-API-KEY'] == current_game.player_2.api_key
      current_game.player_2
    end
  end

end
