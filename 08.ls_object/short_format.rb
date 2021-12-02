# frozen_string_literal: true

require './option'
require './filedata'

class ShortFormat
  COLUMNS = 3.to_f
  COLUMN_SPACE = 5

  def initialize(option)
    @filedata = Filedata.new(option).filedata
  end

  def output
    filenames = @filedata.each_slice((@filedata.length / COLUMNS).ceil).to_a

    (filenames.first.length - filenames.last.length).times do
      filenames.last << ' '
    end

    transposed_filenames = filenames.transpose
    longest_filename_length = @filedata.map(&:length).max

    transposed_filenames.each do |filename|
      filename.each do |file|
        print file.ljust(longest_filename_length + COLUMN_SPACE, ' ')
      end
      print "\n"
    end
  end
end
