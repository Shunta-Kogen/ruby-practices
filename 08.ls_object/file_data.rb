# frozen_string_literal: true

require 'etc'

class FileData
  FILETYPE_TABLE = {
    '01' => 'p',
    '02' => 'c',
    '04' => 'd',
    '06' => 'b',
    '10' => '-',
    '12' => 'l',
    '14' => 's'
  }

  PERMISSION_TABLE = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }

  attr_reader :name

  def initialize(file)
    @file_stat = File::Stat.new(file)
    @name = file
  end

  def blocks
    @file_stat.blocks
  end

  def filemode
    filemode_number = @file_stat.mode.to_s(8).rjust(6, '0')

    filetype_number = filemode_number[0..1]
    permission_number = filemode_number[3..5]

    FILETYPE_TABLE[filetype_number] +
    PERMISSION_TABLE[permission_number[0]] +
    PERMISSION_TABLE[permission_number[1]] +
    PERMISSION_TABLE[permission_number[2]]
  end

  def hardlink
    @file_stat.nlink
  end

  def owner
    Etc.getpwuid(@file_stat.uid).name
  end

  def group
    Etc.getgrgid(@file_stat.gid).name
  end

  def filesize
    @file_stat.size
  end

  def mtime
    @file_stat.mtime
  end
end
