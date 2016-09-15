class Tile
  attr_accessor :value, :state
  def initialize
    @value = 0
    @state = false
  end

  def flag
    @state = nil
  end

  def unflag
    @state = false
  end

  def reveal
    @state = true
  end
end
