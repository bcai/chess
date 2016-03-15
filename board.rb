require_relative 'manifest'

class Board
	def initialize
		@grid = Array.new(8){Array.new(8){EmptySpace.new}}
	end

  def render
    puts "  #{(0...8).to_a.join(" ")}"

    @grid.each_with_index do |row, index|
      print "#{index} "
      row.each {|col| "# {col} "}
      puts
    end
  end

  def move(start,end_pos)
    
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos,value)
    x,y = pos
    @grid[x][y] = value
  end

end

if $0 == __FILE__
  b = Board.new
  # b[[0,0]] = Piece.new
  b.render
end