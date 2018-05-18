class TurnProcessor
  def initialize(game, target, current_player, current_opponent)
    @game   = game
    @target = target
    @messages = []
    @current_opponent = current_opponent
    @current_player = current_player
  end

  def run!
    begin
      attack_opponent
      # ai_attack_back
      switch_turns
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target

  def attack_opponent
    result = Shooter.new(board: @current_opponent.board, target: target).fire!
    @messages << "Your shot resulted in a #{result}."
    @current_player.turns += 1 #do we want this?
  end

  def switch_turns
    if game.current_turn == 'player_1'
      game.current_turn = 'player_2'
    else
      game.current_turn = 'player_1'
    end
  end

  # def ai_attack_back
  #   result = AiSpaceSelector.new(player.board).fire!
  #   @messages << "The computer's shot resulted in a #{result}."
  #   game.player_2.turns += 1
  # end
  #
  # def player
  #   Player.new(game.player_1_board)
  # end
  #
  # def opponent
  #   Player.new(game.player_2.board)
  # end

end
