# functionality common to all pieces 
# require_relative 'board'

class Piece

  attr_reader :color

  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end

  def pos=(pos)
    @pos = pos
  end

  def pos
    @pos
  end

  def color
    @color
  end

  def to_s
    "#{self.symbol}" 
  end

  # def empty?
  #   false
  # end

  # returns an Array of positions a Piece can move to 
  def moves
    # overridden in slideable/stepable modules
  end

  # all moves that will not cause check
  def valid_moves
    moves.reject { |end_pos| move_into_check?(end_pos) }
  end

  private

  def move_into_check?(end_pos)
    test_board = @board.dup
    test_board.move_piece(@pos, end_pos)
    test_board.in_check?(color)
  end
end
