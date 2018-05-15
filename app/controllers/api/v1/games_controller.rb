module Api
  module V1
    class GamesController < ActionController::API
      def create
        player_1 = User.find_by_apikey(request.headers['X-Api-KEY'])
        if User.find_by_email(params['opponent_email']).active?
          player_2 = User.find_by_email(params['opponent_email'])
        else
          flash[:error] = "Sorry, #{params['opponent_email']} hasn't activated their account"
          redirect_to root
        end
        player_1_board = Board.new(4)
        player_2_board = Board.new(4)

        game = Game.create(player_1_board: player_1_board, player_2_board: player_2_board)
        render json: game
      end

      def show
        game = Game.find(params[:id])
        render json: game
      end
    end
  end
end
