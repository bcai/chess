require_relative 'manifest'

class Board

  attr_reader :grid

	def initialize
		create_grid
	end

  def move(turn_color, start, end_pos)
    if self[start].is_a?(EmptySpace)
      raise "Start position is empty! Try again."
    else
      current_piece = self[start]
      x_end, y_end = end_pos
      if current_piece.color != turn_color
        raise "\n* Cannot move opponent's piece! *"
      elsif !(valid_move?(start,end_pos))
        raise "\n* Cannot make such a move! *"
      elsif !(valid_non_check_move?(start,end_pos))
        raise "\n* Cannot move into check! *"
      else
        move_piece(start,end_pos)
      end
    end
  end

  def move_piece(start,end_pos)
      self[end_pos] = self[start]
      self[start].pos = end_pos
      self[start] = EmptySpace.new
  end

  def in_bounds?(pos)
    x,y = pos
    x.between?(0,7) && y.between?(0,7) ? true : false
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos,value)
    x,y = pos
    @grid[x][y] = value
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    
    all_pieces.any? do |piece|
      piece.color != color && piece.moves.include?(king_pos)
    end
  end

  def checkmate?(color)
    return false unless in_check?(color)

    # if player's pieces don't have any valid moves left, game is in checkmate
    all_pieces.select {|p| p.color == color}.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def dup
    new_board = Board.new

    all_pieces.each do |piece|
      x = piece.pos[0]
      y = piece.pos[1]
      new_board[[x,y]] = piece.class.new(new_board, piece.pos, piece.color)
    end

    new_board
  end


  private

  def create_grid 
    @grid = Array.new(8){Array.new(8){EmptySpace.new}}

    #populate with black/white chess pieces
    @grid[0][0] = Rook.new(self, [0,0], "black")
    @grid[0][1] = Knight.new(self, [0,1], "black")
    @grid[0][2] = Bishop.new(self, [0,2], "black")
    @grid[0][3] = Queen.new(self, [0,3], "black")
    @grid[0][4] = King.new(self, [0,4], "black")
    @grid[0][5] = Bishop.new(self, [0,5], "black")
    @grid[0][6] = Knight.new(self, [0,6], "black")
    @grid[0][7] = Rook.new(self, [0,7], "black")

    8.times do |i|
      @grid[1][i] = Pawn.new(self, [1,i], "black")
      @grid[6][i] = Pawn.new(self, [6,i], "white")
    end

    @grid[7][0] = Rook.new(self, [7,0], "white")
    @grid[7][1] = Knight.new(self, [7,1], "white")
    @grid[7][2] = Bishop.new(self, [7,2], "white")
    @grid[7][3] = Queen.new(self, [7,3], "white")
    @grid[7][4] = King.new(self, [7,4], "white")
    @grid[7][5] = Bishop.new(self, [7,5], "white")
    @grid[7][6] = Knight.new(self, [7,6], "white")
    @grid[7][7] = Rook.new(self, [7,7], "white")
  end

  def valid_move?(start,end_pos)
    self[start].moves.include?(end_pos) ? true : false
  end

  def valid_non_check_move?(start,end_pos)
    self[start].valid_moves.include?(end_pos) ? true : false
  end

  def find_king(color)
    all_pieces.each do |piece|
      return piece if (piece.is_a?(King) && piece.color == color)
    end

    raise "King not found"
  end

  def all_pieces
    @grid.flatten.reject { |piece| piece.is_a?(EmptySpace) }
  end
end