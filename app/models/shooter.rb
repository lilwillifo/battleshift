class Shooter
  def initialize(board:, target:)
    @board     = board
    @target    = target
    @message   = ""
  end

  def fire!
    if valid_shot?
      "Your shot resulted in a #{space.attack!}"
    else
      "Invalid coordinates."
    end
  end

  private
    attr_reader :board, :target

    def space
      @space ||= board.locate_space(target)
    end

    def valid_shot?
      board.space_names.include?(target)
    end
end
