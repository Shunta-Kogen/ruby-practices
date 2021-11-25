# frozen_string_literal: true

class Shot
  STRIKE = 10

  def initialize(mark)
    @mark = mark
  end

  def shot_score
    @mark == 'X' ? STRIKE : @mark.to_i
  end
end
