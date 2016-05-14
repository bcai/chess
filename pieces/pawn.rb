require_relative 'piece'
require_relative 'stepable'

class Pawn < Piece

  def initialize(board, pos, color)
    super(board, pos, color)
    @start_pos = @pos
  end

  def move_dirs
    if self.color == "white"
      [[-1,0],[-2,0],[-1,-1],[-1,1]]
    else
      [[1,0],[2,0],[1,-1],[1,1]]
    end
  end

  def moves
    moves = []

    #call move_dirs and generate moves
    move_dirs.each do |x,y|
      moves += valid_positions(x,y)
    end
    moves
  end

  def valid_positions(x,y)
    pos_x,pos_y = @pos
    new_moves = []

    new_pos = [pos_x + x, pos_y + y]

    if @board.in_bounds?(new_pos)
      if (@board[new_pos].is_a?(EmptySpace) && y == 0)
        if @pos == @start_pos # piece is in game-start position
          new_moves << new_pos
        elsif (x == -1 || x == 1)
          new_moves << new_pos
        end
      elsif (@board[new_pos].is_a?(Piece) && y != 0 && @board[new_pos].color != @color)
        new_moves << new_pos
      end
    end

    new_moves
  end

  def symbol
    if @color == "white"
      " ♙ "
    else
      " ♟ "
    end
  end
end