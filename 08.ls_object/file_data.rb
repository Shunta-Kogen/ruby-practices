# frozen_string_literal: true

require 'etc'

class FileData
  attr_reader :name

  def initialize(file)
    @file = File::Stat.new(file)
    @name = file
  end

  def blocks
    @file.blocks
  end

  def filemode
    filemode_number = @file.mode.to_s(8).rjust(6, '0')

    filetype_number = filemode_number[0..1]
    permission_number = filemode_number[3..5]

    filemode = get_filetype(filetype_number) +
               get_permission(permission_number[0]) +
               get_permission(permission_number[1]) +
               get_permission(permission_number[2])
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

  def hardlink
    @file.nlink
  end

  def owner
    Etc.getpwuid(@file.uid).name
  end

  def group
    Etc.getgrgid(@file.gid).name
  end

  def filesize
    @file.size
  end

  def mtime
    @file.mtime
  end
end
