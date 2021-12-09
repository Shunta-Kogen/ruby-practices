# frozen_string_literal: true

require_relative 'file_data'

class ShortFormat
  COLUMNS = 3.to_f
  COLUMN_SPACE = 5

  def initialize(option, file_data)
    @option = option
    @file_data = file_data
    @files = @file_data.map do |file|
      FileData.new(file)
    end
  end

  def output
    filenames = @file_data.each_slice((@file_data.length / COLUMNS).ceil).to_a

    (filenames.first.length - filenames.last.length).times do
      filenames.last << ' '
    end

    transposed_filenames = filenames.transpose
    longest_filename_length = @file_data.map(&:length).max

    transposed_filenames.each do |filename|
      filename.each do |file|
        print file.ljust(longest_filename_length + COLUMN_SPACE, ' ')
      end
      print "\n"
    end
  end
end
