# frozen_string_literal: true

require './shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(frame)
    @frame = frame
    @first_shot = Shot.new(@frame[0]).shot_score
    @second_shot = Shot.new(@frame[1]).shot_score
    @third_shot = Shot.new(@frame[2]).shot_score
  end

  def frame_score
    [first_shot, second_shot, third_shot].sum
  end

  def strike?
    first_shot == 10
  end

  def spare?
    first_shot != 10 && frame_score == 10
  end
end
