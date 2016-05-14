require "byebug"
require_relative 'manifest'

class Board

  attr_reader :grid

	def initialize
		create_grid()
	end

  def move(start,end_pos)
    if self[start].empty?
      begin
        raise ArgumentError.new
      rescue ArgumentError
        # puts "Start position is empty! Try again."
      end
    else
      current_piece = self[start]
      x_end, y_end = end_pos

      if (x_end.between?(0,7) && y_end.between?(0,7) && valid_move?(start,end_pos))
        self[end_pos] = current_piece
        current_piece.pos = end_pos
        self[start] = EmptySpace.new
      else
        begin
          raise ArgumentError.new
        rescue ArgumentError 
          # puts "Invalid Move! Try again."
        end
      end
    end
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
    @grid[0][6] = Knight.new(self, [0,1], "black")
    @grid[0][7] = Rook.new(self, [0,7], "black")

    8.times do |i|
      @grid[1][i] = Pawn.new(self, [1,i], "black")
      @grid[6][i] = Pawn.new(self, [6,i], "white")
    end

    @grid[7][0] = Rook.new(self, [7,0], "white")
    @grid[7][1] = Knight.new(self, [0,1], "white")
    @grid[7][2] = Bishop.new(self, [7,2], "white")
    @grid[7][3] = Queen.new(self, [7,3], "white")
    @grid[7][4] = King.new(self, [7,4], "white")
    @grid[7][5] = Bishop.new(self, [7,5], "white")
    @grid[7][6] = Knight.new(self, [0,1], "white")
    @grid[7][7] = Rook.new(self, [7,7], "white")
  end

  def valid_move?(start,end_pos)
    self[start].moves.include?(end_pos) ? true : false
  end
end

if $0 == __FILE__
  b = Board.new
  d = Display.new(b)
  d.render
  puts "Initialize board\n"
  d.render

  while true
    d.get_input
    d.render
  end
end