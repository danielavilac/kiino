class PagesController < ApplicationController
  respond_to :html, :js
  require 'Matrix'

  def search; end

  def index
    big = 4
    small = 9
    grid = Matrix[[0, 0, 0, 0, 2],
                  [0, 0, 0, 0, 2],
                  [0, 0, 0, 0, 2],
                  [0, 0, 0, 0, 2],
                  [2, 2, 2, 2, 2]]
    
    big.times { grid = add_big(grid) }
    @grid = grid
  end

  private

  def available_big_spaces_in_grid(grid)
    available_spaces = Array.new
    grid.each_with_index do |value, row, col|
      if value == 0 
        available_spaces << [row, col]
      end
    end
    available_spaces
  end

  def add_big(grid)
    asg = available_big_spaces_in_grid(grid).sample
    grid.class.class_eval { public :[]= }
    grid[asg[0], asg[1]] = 1
    # up
    grid[asg[0] - 1, asg[1] - 1] = 2 if grid[asg[0] - 1, asg[1] - 1] != 1 && grid[asg[0] - 1, asg[1] - 1] != 3
    grid[asg[0] - 1, asg[1]] = 2 if grid[asg[0] - 1, asg[1]] != 1 && grid[asg[0] - 1, asg[1]] != 3
    grid[asg[0] - 1, asg[1] + 1] = 2 if grid[asg[0] - 1, asg[1] + 1] != 1 && grid[asg[0] - 1, asg[1] + 1] != 3
    # left and right
    grid[asg[0], asg[1] - 1] = 2 if grid[asg[0], asg[1] - 1] != 1 && grid[asg[0], asg[1] - 1] != 3
    grid[asg[0], asg[1] + 1] = 3 if grid[asg[0], asg[1] + 1] != 1 && grid[asg[0], asg[1] + 1] != 3
    # button
    grid[asg[0] + 1, asg[1] - 1] = 2 if grid[asg[0] + 1, asg[1] - 1] != 1 && grid[asg[0] + 1, asg[1] - 1] != 3
    grid[asg[0] + 1, asg[1]] = 3 if grid[asg[0] + 1, asg[1]] != 1 && grid[asg[0] + 1, asg[1]] != 3
    grid[asg[0] + 1, asg[1] + 1] = 3 if grid[asg[0] + 1, asg[1] + 1] != 1 && grid[asg[0] + 1, asg[1] + 1] != 3
    grid
  end
end
