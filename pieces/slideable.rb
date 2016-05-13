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
    move_dirs.each do |x,y|
      moves += valid_positions(x,y)
    end
    moves
  end

  def move_dirs
    # overridden by subclass
  end


  private

  def valid_positions(x,y)
    pos_x,pos_y = @pos  
    new_moves = []

    blocked = false
    new_pos = [pos_x + x, pos_y + y]

    until (blocked)
      if @board.in_bounds?(new_pos)
        if @board[new_pos].is_a?(EmptySpace)
          new_moves << new_pos
        elsif (@board[new_pos].is_a?(Piece) && @board[new_pos].color != @color)
          # blocking piece is opponent's piece
          new_moves << new_pos
          blocked = true
        else
          blocked = true # piece is friendly
        end
      else
        blocked = true  #out of bounds
      end
      new_pos = [new_pos[0] + x, new_pos[1] + y]
    end

    new_moves
  end

end