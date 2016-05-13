require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
  include Slideable

  def move_dirs
    diagonal_dirs
  end

  def symbol
    if @color == "white"
      " ♗ "
    else
      " ♝ "
    end
  end
end