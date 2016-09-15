class Game

  def self.mine_field(number = 9)
    grid = Array.new(number) { Array.new(9) { Tile.new } }

    Game.new(grid)
  end

  def initialize(grid)
    @grid = grid
  end

  def populate_bombs
    @grid.length.times do
      row, col = randomize
      tile = @grid[row][col]

      until !(tile.value == 0)
        row, col = randomize
        tile = @grid[row][col]
      end
      tile.value = "☼"
    end
  end

  def randomize
    row = rand(@grid.length)
    col = rand(@grid.length)
    [row, col]
  end
end
