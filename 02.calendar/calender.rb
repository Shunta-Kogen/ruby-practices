require "date"
require "optparse"

def calc_weekend_day(first_day)
  case first_day
  when 0 then 7
  when 1 then 6
  when 2 then 5
  when 3 then 4
  when 4 then 3
  when 5 then 2
  else
    1
  end
end

today = Date.today
weekdays = ["日","月","火","水","木","金","土"].join(" ")

opt = OptionParser.new
params = {}
opt.on("-y [VAL]") {|v| params[:y] = v.to_i}
opt.on("-m [VAL]") {|v| params[:m] = v.to_i}
opt.parse!(ARGV)

if (params[:y] && params[:m]).class == Integer #-y,-m両方指定の場合
  puts "#{params[:m]}月 #{params[:y]}".center(20)
  puts weekdays
  begin
    weekday = Date.new(params[:y], params[:m]).wday 
    last_day = Date.new(params[:y], params[:m], -1).day 
  rescue Date::Error, TypeError
    puts "-mは1~12の間の値を入力してください"    
  end

  print "   " * weekday  
  (1..last_day).each do |x| 
    print x.to_s.rjust(2) + " " 
    weekday += 1 
    if weekday % 7 == 0 
      print "\n"
    end
  end
  
  puts "\n"

elsif params[:y].class == NilClass && params[:m].class == Integer #-mのみ指定の場合
  puts "#{params[:m]}月 #{today.year}".center(20)
  puts weekdays
    begin
      weekday = Date.new(today.year, params[:m]).wday 
      last_day = Date.new(today.year, params[:m], -1).day 
    rescue TypeError, Date::Error
      puts "-mは1~12の間の値を入力してください"   
    end
  
    print "   " * weekday  
    (1..last_day).each do |x| 
      print x.to_s.rjust(2) + " " 
      weekday += 1 
      if weekday % 7 == 0 
        print "\n"
      end
    end
  
    puts "\n"

elsif params[:y].class == Integer && params[:m].class == NilClass #-yのみ指定の場合(未完成)
  puts "#{params[:y]}".center(60)

  (1..3).each do |x|
    print "#{x}月".center(20)
  end
  puts "\n"

  puts "#{weekdays} " * 3

  (1..3).each do |x|

    week_day = Date.new(params[:y], x).wday 
    first_day = Date.new(params[:y], x, 1).wday
    month_first_date = Date.new(params[:y], x, 1) 
    month_last_date = Date.new(params[:y], x, -1) 
    weekend_day = calc_weekend_day(first_day)
    current_week_first_date = Date.new(params[:y], x, weekend_day)
    
    print "   " * week_day  
    (month_first_date..month_last_date).each do |date| 
      print date.day.to_s.rjust(2) + " " 
      break if date.saturday? == true
    end
  end
  puts "\n"

  (1..3).each do |x|

    first_day = Date.new(params[:y], x, 1).wday
    month_last_date = Date.new(params[:y], x, -1) 
    weekend_day = calc_weekend_day(first_day)
    current_week_first_date = Date.new(params[:y], x, weekend_day + 1)

    (current_week_first_date..month_last_date).each do |date| 
      print date.day.to_s.rjust(2) + " " 
      break if date.saturday? == true
    end
  end
  puts "\n"

  (1..3).each do |x|

    first_day = Date.new(params[:y], x, 1).wday
    month_last_date = Date.new(params[:y], x, -1) 
    weekend_day = calc_weekend_day(first_day)
    current_week_first_date = Date.new(params[:y], x, weekend_day + 8)

    (current_week_first_date..month_last_date).each do |date| 
      print date.day.to_s.rjust(2) + " " 
      break if date.saturday? == true 
    end
  end
  puts "\n"

  (1..3).each do |x|

    first_day = Date.new(params[:y], x, 1).wday
    weekend_day = calc_weekend_day(first_day)
    month_last_date = Date.new(params[:y], x, -1) 
    current_week_first_date = Date.new(params[:y], x, weekend_day + 15)

    (current_week_first_date..month_last_date).each do |date| 
      print date.day.to_s.rjust(2) + " " 
      break if date.saturday? == true
    end
  end
  puts "\n"

  (1..3).each do |x|
    first_day = Date.new(params[:y], x, 1).wday
    month_last_date = Date.new(params[:y], x, -1) 
    weekend_day = calc_weekend_day(first_day)
    current_week_first_date = Date.new(params[:y], x, weekend_day + 22)

    (current_week_first_date..month_last_date).each do |date| 
      print date.day.to_s.rjust(2) + " " 
      break if date.saturday? == true
    end
  end
  puts "\n"

  puts "\n" #%非表示のため

else #指定なしの場合
  puts "#{today.month}月 #{today.year}".center(20)
  puts weekdays
  weekday = Date.new(today.year, today.month).wday 
  last_day = Date.new(today.year, today.month, -1).day  

  print "   " * weekday  
  (1..last_day).each do |x| 
    print x.to_s.rjust(2) + " " 
    weekday += 1 
    if weekday % 7 == 0 
      print "\n"
    end
  end
    
  puts "\n"

end
require "date"
require "optparse"

today = Date.today

opt = OptionParser.new
params = {}
opt.on("-y [VAL]") {|v| params[:y] = v.to_i}
opt.on("-m [VAL]") {|v| params[:m] = v.to_i}
opt.parse!(ARGV)

if (params[:y] || params[:m]).nil?
  puts "#{today.month}月 #{today.year}".center(20)
else
  puts "#{params[:m]}月 #{params[:y]}".center(20)
end

weekdays = ["日","月","火","水","木","金","土"].join(" ") 
puts weekdays

begin
  weekday = Date.new(params[:y], params[:m]).wday 
  last_day = Date.new(params[:y], params[:m], -1).day 
rescue TypeError 
  weekday = Date.new(today.year, today.month).wday 
  last_day = Date.new(today.year, today.month, -1).day  
end

print "   " * weekday  

(1..last_day).each do |x| 
  print x.to_s.rjust(2) + " " 
  weekday += 1 
  if weekday % 7 == 0 
    print "\n"
  end
end

puts "\n"


