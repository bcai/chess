require_relative 'manifest'

class Board

  attr_reader :grid

	def initialize(populate = false)
		create_grid(populate)
	end

  def move(start,end_pos)
    if self[*start].empty?
      raise ArgumentError.new("Start position is empty!")
    else
      current_piece = self[*start]
      x_end, y_end = end_pos
      if x_end.between?(0,7) && y_end.between?(0,7)
        self[*end_pos] = current_piece
        self[*start] = EmptySpace.new
      else
        raise ArgumentError.new("Invalid end position!")
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

  protected
  def create_grid(populate)
    @grid = Array.new(8){Array.new(8){EmptySpace.new}}
    return unless populate
    #populate with black/white chess pieces
    #...
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
  while true
    d.get_input
    d.render
  end
end