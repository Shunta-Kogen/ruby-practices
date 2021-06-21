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

# ストライクのスコア配列を[10]に変換
frames.each do |frame|
  frame.pop(1) if frame[0] == 10
end

# 10フレームのスコアを1つの配列に結合
case frames.length
when 11
  frames[9].concat(frames[10])
  frames.pop(1)
when 12
  frames[9].concat(frames[10], frames[11])
  frames.pop(2)
end

# スコア計算
point = 0
frames.each_with_index do |frame, i|
  case i
  # 1~8フレーム
  when 0..7
    point += if frame[0] == 10 && frames[i + 1][0] == 10 # ダブル
               10 + 10 + frames[i + 2][0]
             elsif frame[0] == 10 # ストライク
               10 + frames[i + 1].sum
             elsif frame.sum == 10 # スペア
               10 + frames[i + 1][0]
             else
               frame.sum
             end
  # 9フレーム
  when 8
    point += if frame[0] == 10 && frames[9][1] == 10 # ダブル
               10 + 10 + frames[9][1]
             elsif frame[0] == 10 # ストライク
               10 + frames[9][0] + frames[9][1]
             elsif frame.sum == 10 # スペア
               10 + frames[9][0]
             else
               frame.sum
             end
  # 10フレーム
  when 9
    point += frame.sum
  end
end

p point
