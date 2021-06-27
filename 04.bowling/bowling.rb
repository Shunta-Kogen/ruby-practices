# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
STRIKE = 10

shots = scores.map { |s| s == 'X' ? STRIKE : s.to_i }

# 10フレームに分割
frames = []
10.times do |i|
  shots.first == STRIKE ? frames << [shots.shift] : frames << shots.shift(2)
  frames[-1].concat(shots) if i == 9
end

# スコア計算
point = 0
frames.each_with_index do |frame, i|
  case i
  # 1~9フレーム
  when 0..8
    point += if frame[0] == STRIKE && frames[i + 1][0] == STRIKE && i == 8 # 9フレーム目でのダブル
               STRIKE + STRIKE + frames[i + 1][1]
             elsif frame[0] == STRIKE && frames[i + 1][0] == STRIKE # ダブル
               STRIKE + STRIKE + frames[i + 2][0]
             elsif frame[0] == STRIKE # ストライク
               STRIKE + frames[i + 1][0] + frames[i + 1][1]
             elsif frame.sum == STRIKE # スペア
               STRIKE + frames[i + 1][0]
             else
               frame.sum
             end
  # 10フレーム
  when 9
    point += frame.sum
  end
end

p point

