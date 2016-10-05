class Game
  def initialize(input:)
    @state = parse_state(input)
  end

  def displayed_state
    @state
  end

  # Starts from 0,0 at upper left
  def at(x,y)
    @state[y][x] rescue " "
  end

  def tick
    new_state = @state.map(&:dup)

    @state.each_with_index do |row, y|
      x = 0
      row.each_char do |_cell|
        new_state[y][x] = apply_rules(x, y)
        x += 1
      end
    end
  end

  # Any live cell with fewer than two live neighbours dies, as if caused by under-population.
  # Any live cell with two or three live neighbours lives on to the next generation.
  # Any live cell with more than three live neighbours dies, as if by over-population.
  # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  def apply_rules(x, y)
    neighbors = [
      at(x-1, y-1), at(x, y-1), at(x+1, y-1),
      at(x-1, y),               at(x+1, y),
      at(x-1, y+1), at(x, y+1), at(x+1, y+1) ]

    num_alive = neighbors.select {|n| n == "X"}.count
    puts num_alive
    puts neighbors.to_s

    if num_alive < 2 || num_alive > 3
      return " "
    elsif num_alive == 3 || (at(x,y) == " " && num_alive == 3)
      return "X"
    end
  end

  private

  def parse_state(input)
    input.split("\n")
  end
end
