# frozen_string_literal: true

require './option'
require './filedata'
require './short_format'
require './long_format'

class Ls
  def initialize(option)
    @option = Option.new(option)
    @short_format = ShortFormat.new(option)
    @long_format = LongFormat.new(option)
  end

  def output
    if @option.l_option?
      @long_format.output
    else
      @short_format.output
    end
  end
end

option = ARGV.getopts('a', 'l', 'r')
ls = Ls.new(option)
ls.output
