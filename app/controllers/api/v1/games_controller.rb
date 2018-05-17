module Api
  module V1
    class GamesController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      def create
        player_1 = User.find_by_apikey(request.headers['X-Api-KEY'])
        if User.find_by_email(params['opponent_email']).active?
          player_2 = User.find_by_email(params['opponent_email'])
        else
          flash[:error] = "Sorry, #{params['opponent_email']} hasn't activated their account"
          redirect_to root
        end

        game = Game.create(player_1: Player.new(Board.new(4), player_1.apikey), player_2: Player.new(Board.new(4), player_2.apikey))
        # flash[:welcome] = "Ahoy! You're playing on a 4x4 grid and you have 2 ships of lengths 3 and 2 to place"
        render json: game
      end

      def show
        game = Game.find(params[:id])

        render json: game
      end

      def record_not_found(exception)
        render json: {error: exception.message}, status: 400
      end
    end
  end
end
