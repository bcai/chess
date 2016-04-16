# functionality for pieces that step

module Stepable

  

  # returns an Array of positions a Piece can move to 
  # makes use of move_dirs implemented in subclass pieces
  def moves

  end

  def move_dirs
    # overriden by subclass
  end

end