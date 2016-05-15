require_relative 'display'
require_relative 'player'

class HumanPlayer < Player

  def make_move(board)
    start = nil
    end_pos = nil

    until start && end_pos
      @display.render

      if start
        puts "\n#{color.capitalize}'s turn."
        end_pos = @display.get_input

        display.reset! if end_pos
      else
        puts "\n#{color.capitalize}'s turn."
        start = @display.get_input

        @display.reset! if start
      end
    end
    [start, end_pos]
  end

end