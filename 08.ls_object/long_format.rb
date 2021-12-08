# frozen_string_literal: true

require './option'
require './filedata'
require 'etc'
require 'date'
require 'optparse'

class LongFormat
  def initialize(option)
    @filedata = Filedata.new(option).filedata
  end

  def output
    total_blocks
    @filedata.each do |data|
      file = File::Stat.new(data)
      filemode(file)
      hardlink(file)
      access_right(file)
      filesize(file)
      timestamp(file)
      filename(data)
    end
  end

  def total_blocks
    puts "total #{@filedata.sum { |data| File::Stat.new(data).blocks }}"
  end

  def filemode(file)
    filemode_number = file.mode.to_s(8).rjust(6, '0')
    filetype_number = filemode_number[0..1]
    permission_number = filemode_number[3..5]

    print get_filetype(filetype_number)
    print get_permission(permission_number[0])
    print get_permission(permission_number[1])
    print get_permission(permission_number[2]).ljust(4)
  end

  def get_filetype(filetype_number)
    {
      '01': 'p',
      '02': 'c',
      '04': 'd',
      '06': 'b',
      '10': '-',
      '12': 'l',
      '14': 's'
    }[filetype_number.to_sym]
  end

  def get_permission(permission_number)
    {
      '0': '---',
      '1': '--x',
      '2': '-w-',
      '3': '-wx',
      '4': 'r--',
      '5': 'r-x',
      '6': 'rw-',
      '7': 'rwx'
    }[permission_number.to_sym]
  end

  def hardlink(file)
    print file.nlink.to_s.rjust(3)
    print ' '
  end

  def access_right(file)
    print Etc.getpwuid(file.uid).name.ljust(10)
    print Etc.getgrgid(file.gid).name.ljust(6)
  end

  def filesize(file)
    print file.size.to_s.rjust(5)
    print ' '
  end

  def timestamp(file)
    time_stamp = file.mtime
    time_stamp_to_date = time_stamp.to_date
    today_to_6_months_ago = Range.new(Date.today << 6, Date.today)

    if today_to_6_months_ago.cover?(time_stamp_to_date)
      print time_stamp.strftime('%_m %e %R').ljust(12)
    else
      print time_stamp.strftime('%_m %e %Y').ljust(11)
    end
  end

  def filename(files)
    puts files
  end
end
