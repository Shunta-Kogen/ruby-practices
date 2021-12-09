# frozen_string_literal: true

require_relative 'file_data'

class LongFormat
  def initialize(option, file_data)
    @option = option
    @file_data = file_data
    @files = @file_data.map do |file|
      FileData.new(file)
    end
  end

  def output
    total_blocks
    @files.each_with_index do |file, i|
      file.filemode
      file.hardlink
      file.owner
      file.group
      file.filesize
      file.timestamp
      print @file_data[i]
      print "\n"
    end
  end

  private

  def total_blocks
    puts "total #{@files.sum(&:blocks)}"
  end
end
