class Board
  attr_reader :length,
              :board,
              :ships_remaining

  def initialize(length)
    @length = length
    @board = create_grid
    @ships_remaining = [3, 2]
  end

  def get_row_letters
    ("A".."Z").to_a.shift(@length)
  end

  def get_column_numbers
    ("1".."26").to_a.shift(@length)
  end

  # returns array of all spaces ['A1', 'A2', 'B1', 'B2']
  def space_names
    get_row_letters.map do |letter|
      get_column_numbers.map do |number|
        letter + number
      end
    end.flatten
  end

  def create_spaces
    space_names.map do |name|
      [name, Space.new(name)]
    end.to_h
  end
  # wraps each space into a row array
  #[["A1", "A2", "A3", "A4"], ["B1", "B2", "B3", "B4"], ["C1", "C2", "C3", "C4"], ["D1", "D2", "D3", "D4"]]
  def assign_spaces_to_rows
    space_names.each_slice(@length).to_a
  end

  # array of row arrays, each row array has hash with 'A1' => Space object
  def create_grid
    spaces = create_spaces
    assign_spaces_to_rows.map do |row|
      row.each.with_index do |coordinates, index|
        row[index] = {coordinates => spaces[coordinates]}
      end
    end
  end

  def locate_space(coordinates)
    @board.each do |row|
      row.each do |space_hash|
        return space_hash[coordinates] if space_hash.keys[0] == coordinates
      end
    end
  end

def defeated?
  unless empty_board?
    board_values.all? do |space|
      space.values.first.contents.nil? || space.values.first.contents.is_sunk?
    end
  end
end

def empty_board?
  board_values.all? do |space|
    space.values.first.contents.nil?
  end
end

def board_values
  board.flatten
end
end
