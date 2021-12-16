# frozen_string_literal: true

require 'date'

class LongFormatter
  def initialize(option, file_data_list)
    @option = option
    @file_data_list = file_data_list
  end

  def output
    puts "total #{@file_data_list.sum(&:blocks)}"

    @file_data_list.each do |file_data|
      print file_data.filemode.ljust(4)
      print "#{file_data.hardlink.to_s.rjust(3)} "
      print file_data.owner.ljust(10)
      print file_data.group.ljust(6)
      print "#{file_data.filesize.to_s.rjust(5)} "
      print time_stamp(file_data.mtime).ljust(12)
      print file_data.name
      print "\n"
    end
  end

  private

  def time_stamp(mtime)
    time_stamp_to_date = mtime.to_date
    today_to_6_months_ago = Range.new(Date.today << 6, Date.today)
    if today_to_6_months_ago.cover?(time_stamp_to_date)
      mtime.strftime('%_m %e %R')
    else
      mtime.strftime('%_m %e  %Y')
    end
  end
end
