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

  def color
    @color
  end

  def to_s
    "#{self.symbol}" 
  end

  def empty?
    false
  end

  # returns an Array of positions a Piece can move to 
  def moves
    # overridden in slideable/stepable modules
  end
end