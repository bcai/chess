# functionality common to all pieces 

class Piece

  def initialize

  end

  def to_s
    " ♞ " 
  end

  def empty?
    false
  end

  # returns an Array of positions a Piece can move to 
  # overridden in slideable/stepable modules
  def moves

  end
end