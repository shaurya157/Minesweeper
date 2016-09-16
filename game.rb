require_relative 'tile.rb'
require_relative 'board.rb'
require_relative 'player.rb'

class Game
  def initialize(player, number = 9)
    @board = Board.new(number)
    @player = player
  end

  def display
    str = "😀 |"
    0.upto(@board.grid.length-1) do |num|
      str += " #{num} |"
    end
    p str
    str = "-"*str.length
    p str
    @board.grid.each.with_index do |row, index|
      str = "#{index} |"
      row.each do |tile|
        if tile.state.nil?
          str += " ❗ |"
        elsif tile.state
          str += " #{tile.value} |"
        else
          str += " ■ |"
        end
      end
      p str
    end
  end

  def run
    until @board.grid.all? {|row| row.all? {|tile| tile.state || tile.state.nil?}}
      display
      take_turn
    end
  end

  def take_turn
    if @player.flag?
      move = gets_move
      @board[move].state.nil? ? @board[move].unflag : @board[move].flag
    else
      move = gets_move

      if @board[move].value.is_a?(String)
        game_over
      elsif @board[move].value > 0
        @board[move].reveal
      else
        @board.recursive_reveal(move)
      end
    end
  end

  def game_over
    @board.grid.each {|row| row.each {|tile| tile.reveal}}
    display
  end

  def gets_move
    move = @player.get_move
    until valid_move?(move)
      p 'Invalid move'
      move = @player.get_move
    end
    move
  end

  def valid_move?(move)
    return false if move.any? {|num| num > @board.grid.length || num < 0}
    return true if @board[move].state.nil?
    !@board[move].state
  end
end

player = Player.new("Shaurya")
game = Game.new(player, 9)
game.run
