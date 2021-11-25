# frozen_string_literal: true

require 'minitest/autorun'
require './frame'

class FrameTest < Minitest::Test
  def test_frame00
    frame = [0, 0]
    frame_test = Frame.new(frame)
    assert_equal 0, frame_test.score
  end

  def test_frame54
    frame = [5, 4]
    frame_test = Frame.new(frame)
    assert_equal 9, frame_test.score
  end

  def test_strike10
    frame = [10]
    frame_test = Frame.new(frame)
    assert frame_test.strike?
  end

  def test_strike55
    frame = [5, 5]
    frame_test = Frame.new(frame)
    refute frame_test.strike?
  end

  def test_strike54
    frame = [5, 4]
    frame_test = Frame.new(frame)
    refute frame_test.strike?
  end

  def test_spare10
    frame = [10]
    frame_test = Frame.new(frame)
    refute frame_test.spare?
  end

  def test_spare55
    frame = [5, 5]
    frame_test = Frame.new(frame)
    assert frame_test.spare?
  end

  def test_spare54
    frame = [5, 4]
    frame_test = Frame.new(frame)
    refute frame_test.spare?
  end
end
