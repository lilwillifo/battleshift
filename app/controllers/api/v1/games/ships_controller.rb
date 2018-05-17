class Api::V1::Games::ShipsController < ApiController
  def create
    ship_placer = ShipPlacer.new(ship_placer_params)
    ship_placer.run
    current_game.save!
    render json: current_game, message: ship_placer.message
  end

  private
  def ship_placer_params
    {
      start_space: params[:start_space],
      end_space: params[:end_space],
      board: current_player.board,
      ship: Ship.new(params[:ship_size].to_i)
    }
  end
end
