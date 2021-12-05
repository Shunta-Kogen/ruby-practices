# frozen_string_literal: true

require './shot'
require './frame'

class Game
  STRIKE = 10

  def initialize(marks)
    shots = marks.split(',')
    @frames = 10.times.map do |i|
      if (0..8).include?(i)
        Frame.new(shots.first == 'X' ? [shots.shift] : shots.shift(2))
      else
        Frame.new(shots)
      end
    end
  end

  def score
    game_score = 0
    @frames.each_with_index do |frame, i|
      case i
      when 0..8
        game_score += if i == 8 && frame.strike? && @frames[i + 1].strike?
                        STRIKE + STRIKE + @frames[i + 1].second_shot
                      elsif frame.strike? && @frames[i + 1].strike?
                        STRIKE + STRIKE + @frames[i + 2].first_shot
                      elsif frame.strike?
                        STRIKE + @frames[i + 1].first_shot + @frames[i + 1].second_shot
                      elsif frame.spare?
                        STRIKE + @frames[i + 1].first_shot
                      else
                        frame.score
                      end
      when 9
        game_score += frame.score
      end
    end
    score
  end
end

marks = ARGV[0]
game = Game.new(marks)
