#What do we need for tic-tac-toe
# game board
# players
#   Place markers
#     constraints (can't put marker where one already is)
#     how will users choose their locations?
#     check win condition after each move after 5th move
# markers
#   can be X or O
# game conditions
#   win
#     what does win mean?
#   lose
#   draw
#     what does draw mean?
#   game
#     ends at win condition, or 9 moves played with no winner
#   round
#     each player makes 1 move
#   

class Game
  attr_accessor :board

  def create_board(n, val)
    Array.new(n) {Array.new(n) { val }}
  end

  def initialize(name, player1, player2)
    @name = name
    @board = create_board(3, '[ ]')
    @player1 = player1
    @player2 = player2
    game(player1, player2)
  end

  def setup_game
    self.rules
  end

  def print_board
    puts ""
    print "#{board[0][0]}#{board[0][1]}#{board[0][2]}"
    puts ""
    print "#{board[1][0]}#{board[1][1]}#{board[1][2]}"
    puts ""
    print "#{board[2][0]}#{board[2][1]}#{board[2][2]}"
    puts ""
    puts ""
  end

  def rules
    puts "---------------------------------------------------------------------------------------------------------------"
    puts "                                                     Tic-Tac-Toe"
    puts "---------------------------------------------------------------------------------------------------------------"
    puts "1. Alternate turns placing markers until someone gets 3 markers in a row, or the board is filled with no winner"
    puts "2. Markers are put on the board by selecting a row and a column placement"
  end

  def win?(player)
    if (self.board[0][0] == "[X]" && self.board[0][1] == "[X]" && self.board[0][2] == "[X]") ||
       (self.board[0][0] == "[O]" && self.board[0][1] == "[O]" && self.board[0][2] == "[O]") ||
       (self.board[1][0] == "[X]" && self.board[1][1] == "[X]" && self.board[1][2] == "[X]") ||
       (self.board[1][0] == "[O]" && self.board[1][1] == "[O]" && self.board[1][2] == "[O]") ||
       (self.board[2][0] == "[X]" && self.board[2][1] == "[X]" && self.board[2][2] == "[X]") ||
       (self.board[2][0] == "[O]" && self.board[2][1] == "[O]" && self.board[2][2] == "[O]") ||
       (self.board[0][0] == "[X]" && self.board[1][0] == "[X]" && self.board[2][0] == "[X]") ||
       (self.board[0][0] == "[0]" && self.board[1][0] == "[0]" && self.board[2][0] == "[0]") ||
       (self.board[0][1] == "[X]" && self.board[1][1] == "[X]" && self.board[2][1] == "[X]") ||
       (self.board[0][1] == "[0]" && self.board[1][1] == "[0]" && self.board[2][1] == "[0]") ||
       (self.board[0][2] == "[X]" && self.board[1][2] == "[X]" && self.board[2][2] == "[X]") ||
       (self.board[0][2] == "[0]" && self.board[1][2] == "[0]" && self.board[2][2] == "[0]") ||
       (self.board[0][0] == "[X]" && self.board[1][1] == "[X]" && self.board[2][2] == "[X]") ||
       (self.board[0][0] == "[O]" && self.board[1][1] == "[O]" && self.board[2][2] == "[O]") ||
       (self.board[2][0] == "[X]" && self.board[1][1] == "[X]" && self.board[0][2] == "[X]") ||
       (self.board[2][0] == "[O]" && self.board[1][1] == "[O]" && self.board[0][2] == "[O]")
      puts "#{player.name} has won the game!"
      puts ""
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      return true
    end
  end

  def draw?
    unless self.board[0][0] == "[ ]" ||
        self.board[0][1] == "[ ]" ||
        self.board[0][2] == "[ ]" ||
        self.board[1][0] == "[ ]" ||
        self.board[1][1] == "[ ]" ||
        self.board[1][2] == "[ ]" ||
        self.board[2][0] == "[ ]" ||
        self.board[2][1] == "[ ]" ||
        self.board[2][2] == "[ ]"
      return true
    end
  end

  def announce_players(player1, player2)
    puts ""
    puts "#{player1}"
    puts ""
    puts "#{player2}"
    puts ""
  end

  def move(player)
    puts "#{player.name}: Your turn"
    self.print_board
    player.place_marker(self.board)
    self.print_board
    if self.win?(player)
      puts "#{player} wins! Play again - y/n?"
      replay = gets.chomp
      if replay == "y"
        @board = create_board(3, '[ ]')
        game(@player1, @player2)
      else
        puts "Thanks for playing!"
      end
    end
    if self.draw?
      puts "No Remaining Moves. Play again - y/n?"
      replay = gets.chomp
      if replay == "y"
        @board = create_board(3, '[ ]')
        game(@player1, @player2)
      else
        puts "Thanks for playing!"
      end
    end
  end

  def round(player1, player2)
    move(player1)
    move(player2)
  end

  def game (player1, player2)
    setup_game
    5.times do |i|
      puts "============================================================================================"
      puts ""
      puts "Round #{i + 1}"
      round(player1, player2)
      puts ""
      puts "============================================================================================"
    end
  end
end

class Player

  attr_accessor :name, :marker

  def initialize(marker)
    @name = get_name
    @marker = marker
  end

  def get_name
    puts "What is your name?"
    gets.chomp  
  end

  def to_s
    "#{name} will use #{marker}"
  end

  def place_marker(obj)
    puts "Which row would you like to place your marker?"
    row = gets.to_i
    puts "Which column would you like to place your marker?"
    column = gets.to_i
    begin
      if obj[row-1][column-1] == "[ ]"
        obj[row-1][column-1] = "[#{@marker}]"
      else
        puts ""
        puts "!!!!!!!! Invalid Option, make another selection !!!!!!!!!"
        puts ""
        place_marker(obj)
      end
    rescue NoMethodError
      puts ""
      puts "!!!!!!!! Invalid Option, make another selection !!!!!!!!!"
      puts ""
      place_marker(obj)
    end
  end
end

puts "Player 1: "
player1 = Player.new("X")
puts "Player 2: "
player2 = Player.new("O")

ttt = Game.new("ttt", player1, player2)
