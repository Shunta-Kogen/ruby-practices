require 'optparse'
require_relative 'option'
require_relative 'file_data'
require_relative 'short_formatter'
require_relative 'long_formatter'

class Ls
  def initialize(option)
    @option = Option.new(option)
  end

  def output
    file_names = @option.include_dot_file? ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    file_names.reverse! if @option.reverse?
    file_data_list = file_names.map do |file|
      FileData.new(file)
    end
    formatter = @option.long_formatter? ? LongFormatter.new(@option, file_data_list) : ShortFormatter.new(@option, file_data_list)
    formatter.output
  end
end

option = ARGV.getopts('a', 'l', 'r')
ls = Ls.new(option)
ls.output