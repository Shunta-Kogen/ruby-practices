# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # ストライク
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
# 1フレームごとにスコア配列を作る
shots.each_slice(2) do |s|
  frames << s
end

# 1~9フレームのスコア計算
point = 0
frames.each_with_index do |frame, i|
  point += if frame[0] == 10 && frames[i + 1][0] == 10 # ダブル
             10 + 10 + frames[i + 2][0]
           elsif frame[0] == 10 # ストライク
             10 + frames[i + 1].sum
           elsif frame.sum == 10 # スペア
             10 + frames[i + 1][0]
           else
             frame.sum
           end
  # 9フレームまで実行
  break if i == 8
end

# 10フレームのスコア計算
# 10フレームのスコア配列が3つある場合
point += if frames[9][0] == 10 && frames[10][0] == 10
           10 + 10 + frames[11][0]
         # 10フレームのスコア配列が2つある場合
         elsif (frames[9][0] == 10 && frames[10][0] != 10) || frames[9].sum == 10
           10 + frames[10][0]
         else
           frames[9].sum
         end

p point
