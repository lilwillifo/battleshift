module Api
  module V1
    class GamesController < ActionController::API
      def create
        player_1 = request.headers['X-Api-KEY']
        # player_2 = headers, email confirm active status
        # player_1_board = Board.new
        # player_2_board = Board.new
        #
        # game = Game.create(^^^)
        render json: game
      end

      def show
        game = Game.find(params[:id])
        render json: game
      end
    end
  end
end
