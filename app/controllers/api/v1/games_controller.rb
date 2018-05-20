module Api
  module V1
    class GamesController < ApiController
      def create
        if player_2.active?
          game = Game.create(player_1: Player.new(Board.new(4), player_1.apikey), player_2: Player.new(Board.new(4), player_2.apikey))
          render json: game
        else
          render json: {error: "Sorry, #{params['opponent_email']} hasn't activated their account" }, status: 400
        end
      end

      def show
        game = Game.find(params[:id])

        render json: game
      end

      private

      def player_1
        User.find_by_apikey(request.headers['X-Api-KEY'])
      end

      def player_2
        User.find_by_email(params['opponent_email'])
      end
    end
  end
end
