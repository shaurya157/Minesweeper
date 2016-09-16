require_relative 'tile.rb'

class Board
  attr_accessor :grid, :bombs

  def initialize(number = 9)
    @grid = Array.new(number) { Array.new(number) { Tile.new } }
    @bombs = []
    populate_bombs
    set_tile_value
  end

  def populate_bombs
    @grid.length.times do
      row, col = randomize
      tile = @grid[row][col]

      until (tile.value == 0)
        row, col = randomize
        tile = @grid[row][col]
      end
      tile.value = "😹"
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
        row, col = tile
        current_tile = @grid[row][col]
        current_tile.value += 1 if current_tile.value.is_a?(Fixnum)
      end
    end
  end

  def adjacent(position)
    row, col = position
    left_up = [row - 1, col - 1]
    left_down = [row + 1, col - 1]
    right_up = [row - 1, col + 1]
    right_down = [row + 1, col + 1]
    left = [row, col - 1]
    right = [row, col + 1]
    up = [row - 1, col]
    down = [row + 1, col]

    [left_up, left_down, right_up, right_down, up, down, left, right].select do |pos|
      pos.all? {|num| num < @grid.length && num >= 0}
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def recursive_reveal(pos)
    tile = self[pos]

    if tile.value == 0 && !tile.state
      tile.reveal
      adjacent_tiles = adjacent(pos)
      adjacent_tiles.each { |pos| recursive_reveal(pos) }
    elsif tile.value.is_a?(Fixnum)
      tile.reveal
    end
  end
end
