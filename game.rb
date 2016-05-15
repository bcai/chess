require_relative 'board'
require_relative 'human_player'

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      "white" => HumanPlayer.new("white", @display),
      "black" => HumanPlayer.new("black", @display)
    }

    @current_player = "white"
  end

  def play
    until @board.checkmate?(@current_player)
      begin
        start, end_pos = @players[@current_player].make_move(@board)
        @board.move(@current_player, start, end_pos)

        switch_turns!
        notify_players
      rescue StandardError => e
        @display.notifications[:error] = e.message
        retry
      end
    end

    @display.render
    puts "#{current_player} is checkmated."

    nil
  end

  private

  def notify_players
    if @board.in_check?(@current_player)
      @display.set_check!
    else
      @display.uncheck!
    end
  end


  def switch_turns!
    @current_player = (@current_player == "white") ? "black" : "white"
  end
end

if __FILE__ == $0
  Game.new.play
end