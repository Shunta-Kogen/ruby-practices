# frozen_string_literal: true

require 'minitest/autorun'
require './shot'

class ShotTest < Minitest::Test
  def test_shot1
    shot = Shot.new(1)
    assert_equal 1, shot.score
    refute_equal '1', shot.score
  end

  def test_shot10
    shot = Shot.new('X')
    assert_equal 10, shot.score
    refute_equal 'X', shot.score
  end
end
