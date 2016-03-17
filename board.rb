require_relative 'manifest'

class Board
  attr_accessor :grid

	def initialize
		@grid = Array.new(8){Array.new(8){EmptySpace.new}}
	end

  def move(start,end_pos)
    if self[*start].empty?
      raise "Start position is empty!"
    else
      current_piece = self[*start]
      x_end, y_end = end_pos
      if x_end.between?(0,7) && y_end.between?(0,7)
        self[*end_pos] = current_piece
        self[*start] = EmptySpace.new
      else
        raise "Invalid end position!"
      end
    end
  end

  def in_bounds?(pos)
    x,y = pos
    x.between?(0,7) && y.between?(0,7) ? true : false
  end

  def [](*pos)
    x,y = pos[0],pos[1]
    @grid[x][y]
  end

  def []=(*pos,value)
    x,y = pos[0],pos[1]
    @grid[x][y] = value
  end

end

if $0 == __FILE__
  b = Board.new
  d = Display.new(b)
  d.render
  puts "Initialize board\n"
  b[0,0] = Piece.new
  d.render
  puts "New Piece object at [0,0]\n"
  start = [0,0]
  end_pos = [0,1]
  b.move(start,end_pos)
  d.render
  p "[0,0]: #{b[0,0].class}"
  p "[0,1]: #{b[0,1].class}"
  p "[1,0]: #{b[1,0].class}"
end