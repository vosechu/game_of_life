require 'spec_helper'
require 'game'

describe Game do
  it 'exists' do
    # 100x100 grid
    input = " X \nXX \n X "
    game = Game.new(input: input)

    expected_output = ["XXX", "   ", " X "]

    expect { game.tick }.to change {
      game.displayed_state
    }.from([" X ", "XX ", " X "]).to(expected_output)
  end

  describe 'the rules' do
    # Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    it 'satisfies rule 1' do
      input = "   \n X \n   "
      game = Game.new(input: input)

      expect { game.tick }
        .to change { game.at(1,1) }
        .from("X")
        .to(" ")
    end

    # Any live cell with two or three live neighbours lives on to the next generation.
    it 'satisfies rule 2' do
      input = " X \n X \n X "
      game = Game.new(input: input)

      expect { game.tick }
        .to change { game.at(1,1) }
        .from("X")
        .to("X")
    end

    # Any live cell with more than three live neighbours dies, as if by over-population.
    it 'satisfies rule 3' do
      input = " X \nXX \n X "
      game = Game.new(input: input)

      expect { game.tick }
        .to change { game.at(1,1) }
        .from("X")
        .to(" ")
    end

    # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    it 'satisfies rule 4' do
      input = " X \nX  \n X "
      game = Game.new(input: input)

      expect { game.tick }
        .to change { game.at(1,1) }
        .from(" ")
        .to("X")
    end
  end

  describe 'stable shapes' do

  end
end
