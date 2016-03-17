require 'colorize'
require "io/console"

class Display
  
  def initialize(board)
    @cursor_pos = [0,0] #default pos
    @selected_pos = nil
    @selected = false
    @board = board
  end

    KEYMAP = {
    " " => :space,
    "\r" => :return,
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left,
    "q" => :quit,
    "\u0003" => :ctrl_c
  }

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def handle_key(key)
    case key
    when :ctrl_c, :quit
      exit 0
    when :return, :space
      if !@selected 
        @selected_pos = @cursor_pos
        @selected = true
      else
        @board.move(@selected_pos,@cursor_pos)
        @selected_pos = nil
        @selected = false
      end
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      nil
    else
      puts key
    end
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def update_pos(delta)
    new_pos = [@cursor_pos[0] + delta[0], @cursor_pos[1] + delta[1]]
    @cursor_pos = new_pos if @board.in_bounds?(new_pos)
  end


  # all methods below will stay in Display class, all methods above will be
  # moved to HumanPlayer class when implmented.


  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :blue
    elsif [i, j] == @selected_pos
      bg = :blue
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :light_red
    end
    { background: bg, color: :white }
  end


  def render
    system("clear")
    print "  "
    8.times {|idx| print " #{idx} "}
    print "\n"
    @board.grid.map.with_index do |row, i|
      print "#{i} "
      row.map.with_index do |piece, j| 
        color_options = colors_for(i,j)
        print "#{piece.to_s.colorize(color_options)}"
      end
      print "\n"
    end
  end
end