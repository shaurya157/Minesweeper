require_relative 'tile.rb'
require 'byebug'

class Board
  attr_accessor :grid, :bombs

  def initialize(number)
    @grid = Array.new(number) { Array.new(number) { Tile.new } }
    @bombs = []
    populate_bombs
  end

  def populate_bombs
    @grid.length.times do
      row, col = randomize
      tile = @grid[row][col]

      until (tile.value == 0)
        row, col = randomize
        tile = @grid[row][col]
      end
      tile.value = "☼"
      @bombs << [row, col]
    end
  end

  def randomize
    row = rand(@grid.length)
    col = rand(@grid.length)
    [row, col]
  end

  def set_tile_value
    @bombs.each do |position|
      adjacent_tiles = adjacent(position)
      adjacent_tiles.each do |tile|
        next if tile.any? { |x| x < 0 }
        row, col = tile
        next if @grid[row].nil?
        current_tile = @grid[row][col]
        next if current_tile.nil?
        current_tile.value += 1 if current_tile.value.is_a?(Fixnum)
      end
    end
  end

  def adjacent(position)
    row, col = position
    left_up_diag = [row - 1, col - 1]
    left_down_diag = [row + 1, col - 1]
    right_up_diag = [row - 1, col + 1]
    right_down_diag = [row + 1, col + 1]
    left = [row, col - 1]
    right = [row, col + 1]
    up = [row - 1, col]
    down = [row + 1, col]

    [left_up_diag, left_down_diag, right_up_diag, right_down_diag, up, down, left, right]
  end
end

board = Board.new(9)
board.set_tile_value
grid = board.grid
grid.each do |row|
  str = ""
  row.each do |tile|
    str += " #{tile.value} "
  end
  p str
end
