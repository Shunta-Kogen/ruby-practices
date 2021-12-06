# frozen_string_literal: true

require './shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(marks, idx)
    @first_shot = Shot.new(marks[0]).score
    @second_shot = Shot.new(marks[1]).score
    @third_shot = Shot.new(marks[2]).score
    @idx = idx
  end

  def score
    [@first_shot, @second_shot, @third_shot].sum
  end

  def strike?
    @first_shot == 10
  end

  def spare?
    !strike? && score == 10
  end

  def last?
    @idx == 9
  end
end
