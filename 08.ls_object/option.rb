# frozen_string_literal: true

class Option
  def initialize(option)
    @option = option
  end

  def a_option?
    @option['a']
  end

  def l_option?
    @option['l']
  end

  def r_option?
    @option['r']
  end
end
