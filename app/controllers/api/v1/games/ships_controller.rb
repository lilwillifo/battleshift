module Api
  module V1
    module Games
      class ShipsController < ApiController
        def create
          ship = Ship.new(params['ship_size'])
          render json: ship
        end
      end
    end
  end
end
