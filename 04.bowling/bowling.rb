# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  shots << if s == 'X' # ストライク
             10
           else
             s.to_i
           end
end

# スコア配列を1フレームごとに分割
frame = []
loop do
  frame << if shots[0] == 10
             [shots.shift]
           else
             shots.shift(2)
           end
  break if shots[0].nil?
end

# 10フレームのスコアを1つの配列に結合
case frame.length
when 11
  frame[9].concat(frame[10])
  frame.pop(1)
when 12
  frame[9].concat(frame[10], frame[11])
  frame.pop(2)
end

# スコア計算
point = 0
frame.each_with_index do |frames, i|
  case i
  # 1~9フレーム
  when 0..8
    point += if frames[0] == 10 && frame[9][0] == 10 && i == 8 # 9フレーム目でのダブル
               10 + 10 + frame[9][1]
             elsif frames[0] == 10 && frame[i + 1][0] == 10 # ダブル
               10 + 10 + frame[i + 2][0]
             elsif frames[0] == 10 # ストライク
               10 + frame[i + 1][0] + frame[i + 1][1]
             elsif frames.sum == 10 # スペア
               10 + frame[i + 1][0]
             else
               frames.sum
             end
  # 10フレーム
  when 9
    point += frames.sum
  end
end

p point
