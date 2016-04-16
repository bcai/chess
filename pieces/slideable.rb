# functionality for pieces that slide

module Slideable

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

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  # returns an Array of positions a Piece can move to 
  # makes use of move_dirs implemented in subclass pieces
  def moves
    moves = []

    # call move_dirs and generate moves
  end

  def move_dirs
    # overridden by subclass
  end

end