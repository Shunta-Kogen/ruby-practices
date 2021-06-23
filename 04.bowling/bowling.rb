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

# スコア配列を10フレームに分割
frames = []
10.times do |i|
  frames << if shots[0] == 10
              [shots.shift]
            else
              shots.shift(2)
            end

  frames[-1].concat(shots) if i == 9
end

# スコア計算
point = 0
frames.each_with_index do |frame, i|
  case i
  # 1~9フレーム
  when 0..8
    point += if frame[0] == 10 && frames[i + 1][0] == 10 && i == 8 # 9フレーム目でのダブル
               10 + 10 + frames[i + 1][1]
             elsif frame[0] == 10 && frames[i + 1][0] == 10 # ダブル
               10 + 10 + frames[i + 2][0]
             elsif frame[0] == 10 # ストライク
               10 + frames[i + 1][0] + frames[i + 1][1]
             elsif frame.sum == 10 # スペア
               10 + frames[i + 1][0]
             else
               frame.sum
             end
  # 10フレーム
  when 9
    point += frame.sum
  end
end

p point
