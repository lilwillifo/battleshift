class ApiController < ActionController::API
  # before_action :require_api_key
  #
  # def require_api_key
  # end

  def current_game
    game = Game.find(params[:game_id])
  end
end
