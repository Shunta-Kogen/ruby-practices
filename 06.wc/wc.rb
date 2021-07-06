# frozen_string_literal: true

require 'optparse'

option = ARGV.getopts('l')

# 改行数のカウント
def count_lines(read_file)
  print read_file.count("\n")
end

# lオプション
def option_l(read_file)
  print '     '
  print read_file.split(/\s+/).length
  print '    '
  print read_file.bytesize
end

# ファイルごとの情報表示
def file_values(option)
  ARGV.each do |file|
    read_file = File.read(file)
    print '     '
    count_lines(read_file)
    option_l(read_file) if option['l'] != true
    print ' '
    puts file
  end
end

# 引数に複数ファイルを渡された場合のtotal表示
def total_values(option)
  total_lines = 0
  total_words = 0
  total_bytesize = 0
  ARGV.each do |file|
    read_file = File.read(file)
    total_lines += read_file.count("\n")
    total_words += read_file.split(/\s+/).length
    total_bytesize += read_file.bytesize
  end
  print '     '
  print total_lines
  if option['l'] != true
    print '     '
    print total_words
    print '    '
    print total_bytesize
  end
  print ' '
  puts 'total'
end

# 引数が与えられていた場合の出力
def print_wc(option)
  file_values(option)
  total_values(option) if ARGV.length >= 2
end

# 標準入力が与えられた場合の出力
def standard_input_values(option)
  read_file = $stdin.read
  print '     '
  count_lines(read_file)
  option_l(read_file) if option['l'] != true
  print "\n"
end

if ARGV.length >= 1
  print_wc(option)
else
  standard_input_values(option)
end
