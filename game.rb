require_relative 'tile.rb'
require_relative 'board.rb'

class Game
  def self.mine_field(number = 9, player)
    grid = Board.new(number)
    Game.new(grid, player)
  end

  def initialize(board, player)
    @board = grid
    @player = player
  end

  def display
    @board.each { |row| row.each { |tile| puts tile.value } }
  end

  def run
    take_turn until @board.all? {|row| row.all? {|tile| tile.state || tile.state.nil?}}
  end

  def take_turn
    if player.flag?
      move = @player.get_move
      move = @player.get_move until valid_move?(move)
      @board[move].state.nil? @board[move].unflag : @board[move].flag
    else
      move = @player.get_move
      move = @player.get_move until valid_move?(move)
      @board[move].reveal
      game_over if @board[move].value.is_a?(String)
    end
  end

  def game_over
    puts "GAME OVER!"
    display
  end

  def valid_move?(move)
    !(@board[move].state) && !@board[move].value.is_a?(Fixnum)
  end
end
