# frozen_string_literal: true

require 'optparse'

option = ARGV.getopts('l')

# 改行数のカウント
def print_lines(read_file)
  print read_file.count("\n").to_s.rjust(10)
end

# lオプションが指定されない場合
def not_exists_option_l(read_file)
  print read_file.split(/\s+/).length.to_s.rjust(10)
  print read_file.bytesize.to_s.rjust(10)
end

# ファイルごとの情報表示
def print_file_values(option)
  ARGV.each do |file|
    read_file = File.read(file)
    print_lines(read_file)
    not_exists_option_l(read_file) unless option['l']
    puts " #{file}"
  end
end

# 引数に複数ファイルを渡された場合のtotal表示
def print_total_values(option)
  total_lines = 0
  total_words = 0
  total_bytesize = 0
  ARGV.each do |file|
    read_file = File.read(file)
    total_lines += read_file.count("\n")
    total_words += read_file.split(/\s+/).length
    total_bytesize += read_file.bytesize
  end
  print total_lines.to_s.rjust(10)
  unless option['l']
    print total_words.to_s.rjust(10)
    print total_bytesize.to_s.rjust(10)
  end
  puts 'total'.rjust(6)
end

# 引数が与えられていた場合の出力
def print_wc(option)
  print_file_values(option)
  print_total_values(option) if ARGV.length >= 2
end

# 標準入力が与えられた場合の出力
def print_wc_passed_by_stdin(option)
  read_file = $stdin.read
  print_lines(read_file)
  not_exists_option_l(read_file) unless option['l']
  print "\n"
end

if ARGV.length >= 1
  print_wc(option)
else
  print_wc_passed_by_stdin(option)
end
