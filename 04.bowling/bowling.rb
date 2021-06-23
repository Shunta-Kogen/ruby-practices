#frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # ストライク
    shots << 10
  else
    shots << s.to_i
  end
end

# スコア配列を10フレームに分割
frames = []
10.times do |i|
  if shots[0] == 10
    frames << [shots.shift]
  else
    frames << shots.shift(2)
  end
  
  if i == 9
    frames[-1].concat(shots)
  end
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
