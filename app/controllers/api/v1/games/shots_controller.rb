module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          turn_processor = TurnProcessor.new(current_game, params[:shot][:target], current_player, current_opponent)

          turn_processor.run!
          render json: current_game, message: turn_processor.message
        end
      end
    end
  end
end
