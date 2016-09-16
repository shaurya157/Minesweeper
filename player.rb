class Player
  def initialize(name)
    @name = name
  end

  def get_move
    puts "Enter a move as row, col"
    move = parse_move(gets.chomp)
  end

  def flag?
    p "Would you like to flag?(y/n):"
    answer = gets.chomp
  end

  def parse_move(move)
    move.scan(/[0-9]/).map(&:to_i)
  end
end
