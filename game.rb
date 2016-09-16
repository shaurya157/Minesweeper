require_relative 'tile.rb'
require_relative 'board.rb'

class Game
  def self.mine_field(number = 9)
    grid = Board.new(number)
    Game.new(grid)
  end

  def initialize(grid)
    @grid = grid
  end

  def display
    @grid.each { |row| row.each { |tile| puts tile.value } }
  end
end
