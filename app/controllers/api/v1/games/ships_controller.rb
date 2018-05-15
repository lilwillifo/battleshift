module Api
  module V1
    module Games

      class ShipsController < ApiController
        def create
          ship = Ship.new(ship_params)
          binding.pry
          render json: ship
        end

        private
        def ship_params
          params.require(:ship).permit(:ship_size, :start_space, :end_space)
        end
      end

    end
  end
end
