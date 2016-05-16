# Chess

[Chess live][github]

[github]: http://github.com/bcai/chess

Chess is a command-line game built on Ruby using OOP principles and uses `io/console` to take in user inputs through the keyboard.

## Features & Implementation


### Object-Oriented Architecture 

Chess uses a `Board` class to hold `Piece` objects. Pieces are categorized into main types: `Slideable` and `Stepable`. `Slideable` is a ruby module which contains methods and constants relevant to pieces that can jump across the board, such as `Queen`, `Bishop`, and `Rook` all of which inherits form the `Piece` parent class and include the `Slideable` module. 

`Stepable` is included by pieces that move only one step away. Pieces such as `King` and `Knight` will include `Stepable` as well as inherit from the `Piece` parent class.

`Pawn` is a special piece of its own that has its own set of movement rules. Therefore it does not inherit from any of the modules defined.

Based on the piece, say the `Queen`, a set of directional coordinates will be applied to the `#move_dirs` method in the `Queen` class. In this case, `#move_dirs` will contain the sum of both `#diagonal_dirs` and `#horizontal_dirs`.

```javascript
module Slideable

  DIAGONAL_DIRS = [
    [-1,-1],
    [-1,1],
    [1,-1],
    [1,1]
  ]

  HORIZONTAL_DIRS = [
    [-1,0],
    [0,1],
    [1,0],
    [0,-1] 
  ]

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  # returns an Array of positions a Piece can move to 
  # makes use of move_dirs implemented in subclass pieces
  def moves
    moves = []

    # call move_dirs and generate moves
    move_dirs.each do |x,y|
      moves += valid_positions(x,y)
    end
    moves
  end

  def move_dirs
    # overridden by subclass
  end
```

### Movement Filtering

In chess, multiple conditions for a piece needs to be specified, based on the type of piece it is as well as the conditions on the current board.

As mentioned above, the `#move_dirs` of each piece class will contain it's own unique set of directions that the piece can move in. The `#moves` method in the `Slideable` and `Stepable` modules (and the `Pawn` class) will generate all moves that the piece can make, given that the positions are valid. The `#valid_positions` checks that a potential move is `#in_bounds?`, is an `EmptySpace`, is an opposing piece to be taken, or is not occupied by a different piece of the same color.

When `Board#move` is made to actually move the piece, `Board#valid_move` checks whether a move made is within the array of moves that the `#moves` method generates. 


```javascript
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
```

An additional method, `#in_check? will check whether the potential move will cause the player to go into check given that an opposing piece within reach of the player's King can make a game-winning move, and will prevent the player from making such a move by filtering `#moves` into an even further filtered array of `#valid_moves` (all moves that can be made, that will not cause a check).

`#valid_moves` method:

```javascript
  def valid_moves
    moves.reject { |end_pos| move_into_check?(end_pos) }
  end

  private

  def move_into_check?(end_pos)
    test_board = @board.dup
    test_board.move_piece(@pos, end_pos)
    test_board.in_check?(color)
  end
```

### Checkmate

Checking whether a checkmate has occurred requires the current `Board` object to be duplicated so that moves can be made on the separate duped board to check whether the player can make a move that will take the King out of check. If no moves can be generate which can enable the player to safely bring the checked King out of check, a checkmate has resulted.

`Board#checkmate?` method:

```javascript
def checkmate?(color)
  return false unless in_check?(color)

  # if player's pieces don't have any valid moves left, game is in checkmate
  all_pieces.select {|p| p.color == color}.all? do |piece|
    piece.valid_moves.empty?
  end
```