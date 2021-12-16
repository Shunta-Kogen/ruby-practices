# frozen_string_literal: true

class Option
  def initialize(option)
    @option = option
  end

  def include_dot_file?
    @option['a']
  end

  def long_format?
    @option['l']
  end

  def reverse?
    @option['r']
  end
end
