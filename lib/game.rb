class Game
  attr_accessor :board, :player_1, :player_2
  
   WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
    ]
    
  def initialize(player_1 =  Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end
  
  def current_player
    @board.turn_count % 2 == 0 ? player_1 : player_2 
  end
  
  def won?
   WIN_COMBINATIONS.each do |win_combination|
    position_1 = @board.cells[win_combination[0]]
    position_2 = @board.cells[win_combination[1]]
    position_3 = @board.cells[win_combination[2]]
     if position_1 == "X" && position_2 == "X" && position_3 ==  "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
     return win_combination
    end
   end
 false
end

  def draw?
    board.full? && !won?
  end

  def over?
   won? || draw?
  end
  
  def winner
    @board.cells[won?[0]] if won?
  end
  
  def turn
    player = current_player
    current_move = player.move(@board)
    if !@board.valid_move?(current_move)
    turn
  elsif @board.valid_move?(current_move)
  @board.update(current_move, player)
  end
end

  def play 
    while !over?
      turn 
    end 
    if won? !=false
      puts "Congratulations #{winner}!"
  elsif draw? == true 
    puts "Cat's Game!"
  end 
end 
    
end