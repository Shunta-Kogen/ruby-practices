# frozen_string_literal: true

require 'etc'
require 'date'
require 'optparse'

option = ARGV.getopts('a', 'r', 'l')
array = option['a'] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
option['r'] ? array = array.reverse : array

if !option['l']

  # オプションなし
  arrays = []

  # 列数を指定
  COLUMNS = 3.to_f

  # array内の要素を3つの配列に分割
  arrays = array.each_slice((array.length / COLUMNS).ceil).to_a

  # transposeを使う場合、各配列の要素数を合わせる必要があるため
  # カレントディレクトリのファイル数に応じて、分割した最後の配列に空白を追加
  (arrays.first.length - arrays.last.length).times do
    arrays.last << ' '
  end

  # arraysの行と列を入れ替え
  transposed_arrays = arrays.transpose

  # 最も長いファイル名の文字数を取得
  longest_filename_length = array.map(&:length).max

  # 列同士の間隔
  COLUMNN_SPACE = 5

  # 最も長いファイル名を列幅の基準とし、空いたスペースには空白を表示
  transposed_arrays.each do |files|
    files.each do |file|
      print file.ljust(longest_filename_length + COLUMNN_SPACE, ' ')
    end
    print "\n"
  end

else

  # lオプション
  # ファイルタイプを取得
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

  # パーミッションを取得
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

  # ファイルモードを出力
  def filemode(file)
    # 8進数に変換した上で、値が5桁だった場合、先頭に0を追加
    filemode_number = file.mode.to_s(8).rjust(6, '0')
    # ファイルモードをそれぞれに対応した項目ごとに分解する
    filetype_number = filemode_number[0..1]
    permission_number = filemode_number[3..5]
    print get_filetype(filetype_number)
    print get_permission(permission_number[0])
    print get_permission(permission_number[1])
    print get_permission(permission_number[2])
    print '  '
  end

  # ハードリンクの数を出力
  def hardlink(file)
    print file.nlink
    print '  '
  end

  # 所有者/所有者グループを出力
  def access_right(file)
    print Etc.getpwuid(file.uid).name
    print '  '
    print Etc.getgrgid(file.gid).name
    print '  '
  end

  # ファイルサイズを出力
  def filesize(file)
    print file.size
    print ' '
  end

  # タイムスタンプを出力
  def timestamp(file)
    time_stamp = file.mtime
    time_stamp_to_date = time_stamp.to_date
    today_to_6_months_ago = Range.new(Date.today << 6, Date.today)
    print time_stamp.strftime('%_m')
    print ' '
    print time_stamp.strftime('%e')
    print ' '
    # 最終更新が6ヶ月以内の場合、時間を表示
    if today_to_6_months_ago.cover?(time_stamp_to_date)
      print time_stamp.strftime('%R')
    else
      print time_stamp.strftime('%Y')
    end
    print '  '
  end

  # ファイルの名前を出力
  def filename(files)
    puts files
  end

  # 出力処理
  puts "total #{array.sum { |files| File::Stat.new(files).blocks }}"

  array.each do |files|
    file = File::Stat.new(files)
    filemode(file)
    hardlink(file)
    access_right(file)
    filesize(file)
    timestamp(file)
    filename(files)
  end
end
