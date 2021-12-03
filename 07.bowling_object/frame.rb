# frozen_string_literal: true

require './shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(frame)
    @frame = frame
    @first_shot = Shot.new(@frame[0]).score
    @second_shot = Shot.new(@frame[1]).score
    @third_shot = Shot.new(@frame[2]).score
  end

  def score
    [first_shot, second_shot, third_shot].sum
  end

  def strike?
    first_shot == 10
  end

  def spare?
    !strike? && score == 10
  end
end
