# frozen_string_literal: true

require 'minitest/autorun'
require './frame'

class FrameTest < Minitest::Test
  def test_score
    assert_equal 0, Frame.new([0, 0]).score
    assert_equal 10, Frame.new([5, 5]).score
    assert_equal 9, Frame.new([5, 4]).score
  end

  def test_strike
    assert Frame.new([10]).strike?
    refute Frame.new([5, 5]).strike?
    refute Frame.new([5, 4]).strike?
  end

  def test_spare
    refute Frame.new([10]).spare?
    assert Frame.new([5, 5]).spare?
    refute Frame.new([5, 4]).spare?
  end
end
