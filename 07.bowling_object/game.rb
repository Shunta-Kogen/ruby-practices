# frozen_string_literal: true

require './shot'
require './frame'

class Game
  STRIKE = 10

  def initialize(input)
    marks = input.split(',')
    frames = []
    10.times do |i|
      frames << (marks.first == 'X' ? [marks.shift] : marks.shift(2))
      frames[-1].concat(marks) if i == 9
    end
    @frames = frames.map { |frame| Frame.new(frame) }
  end

  def game_score
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
    game_score
  end
end

marks = ARGV[0]
game = Game.new(marks)

puts game.game_score
