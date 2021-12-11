# frozen_string_literal: true

require 'date'

class LongFormat
  def initialize(option, file_data_list)
    @option = option
    @file_data_list = file_data_list
  end

  def output
    total_blocks
    @file_data_list.each do |file_data|
      print file_data.filemode.ljust(4)
      print file_data.hardlink.to_s.rjust(3) + ' '
      print file_data.owner.ljust(10)
      print file_data.group.ljust(6)
      print file_data.filesize.to_s.rjust(5) + ' '

      time_stamp = file_data.mtime
      time_stamp_to_date = time_stamp.to_date
      today_to_6_months_ago = Range.new(Date.today << 6, Date.today)
      if today_to_6_months_ago.cover?(time_stamp_to_date)
        print time_stamp.strftime('%_m %e %R').ljust(12)
      else
        print time_stamp.strftime('%_m %e %Y').ljust(11)
      end

      print file_data.name
      print "\n"
    end
  end

  private

  def total_blocks
    puts "total #{@file_data_list.sum(&:blocks)}"
  end
end
