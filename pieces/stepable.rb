# functionality for pieces that step

module Stepable

  DIAGONAL_DIRS = [
    [-1,-1],
    [-1,1],
    [1,-1],
    [1,1]
  ]

  HORIZONTAL_DIRS = [
    [-1,0],
    [0,1],
    [1,0],
    [0,-1] 
  ]

  KNIGHT_DIRS = [
    [1,-2],
    [-2,-1],
    [-2,1],
    [-1,2],
    [1,2],
    [2,1],
    [2,-1],
    [1,-2]
  ]

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def knight_dirs
    KNIGHT_DIRS
  end
  

  # returns an Array of positions a Piece can move to 
  # makes use of move_dirs implemented in subclass pieces
  def moves
    moves = []

    #call move_dirs and generate moves
    move_dirs.each do |x,y|
      moves += valid_positions(x,y)
    end
    moves
  end

  def move_dirs
    # overriden by subclass
  end

  def valid_positions(x,y)
    pos_x,pos_y = @pos
    new_moves = []

    new_pos = [pos_x + x, pos_y + y]

    if @board.in_bounds?(new_pos)
      if @board[new_pos].is_a?(EmptySpace)
        new_moves << new_pos
      elsif (@board[new_pos].is_a?(Piece) && @board[new_pos].color != @color)
        # blocking piece is opponent's piece
        new_moves << new_pos
      end
    end

    new_moves
  end

end