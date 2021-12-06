# frozen_string_literal: true

require './shot'
require './frame'

class Game
  def initialize(marks)
    shots = marks.split(',')
    @frames = Array.new(10) do |idx|
      if (0..8).cover?(idx)
        Frame.new(shots.first == 'X' ? [shots.shift] : shots.shift(2), idx)
      else
        Frame.new(shots, idx)
      end
    end
  end

  def next_frame(idx)
    @frames[idx + 1]
  end

  def strike_bonus(idx)
    next_frame = next_frame(idx)
    bonus_first_shot = next_frame.first_shot
    bonus_second_shot = if next_frame.strike?
                          idx == 8 ? next_frame.second_shot : @frames[idx + 2].first_shot
                        else
                          next_frame.second_shot
                        end
    [bonus_first_shot, bonus_second_shot].sum
  end

  def spare_bonus(idx)
    next_frame(idx).first_shot
  end

  def score
    @frames.each_with_index.sum do |frame, idx|
      if frame.strike? && !frame.last?
        strike_bonus(idx) + frame.score
      elsif frame.spare? && !frame.last?
        spare_bonus(idx) + frame.score
      else
        frame.score
      end
    end
  end
end

marks = ARGV[0]
game = Game.new(marks)
p game.score
