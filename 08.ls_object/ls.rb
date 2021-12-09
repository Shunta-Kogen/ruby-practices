# frozen_string_literal: true

require 'optparse'
require_relative 'option'
require_relative 'short_format'
require_relative 'long_format'

class Ls
  def initialize(option)
    @option = Option.new(option)
    @file_data = @option.a_option? ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    @file_data.reverse! if @option.r_option?
    @short_format = ShortFormat.new(@option, @file_data)
    @long_format = LongFormat.new(@option, @file_data)
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
