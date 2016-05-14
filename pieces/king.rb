require_relative 'piece'
require_relative 'stepable'

class King < Piece
  include Stepable

  def move_dirs
    diagonal_dirs + horizontal_dirs
  end

  def symbol
    if @color == "white"
      " ♔ "
    else
      " ♚ "
    end
  end
end