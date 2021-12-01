require "date"
require "optparse"

today = Date.today
weekdays = ["日","月","火","水","木","金","土"].join(" ")

opt = OptionParser.new
params = {}
opt.on("-y [VAL]") {|v| params[:y] = v.to_i}
opt.on("-m [VAL]") {|v| params[:m] = v.to_i}
opt.parse!(ARGV)

def output_calender(weekday, last_day)
  print "   " * weekday  
  (1..last_day).each do |date| 
    print date.to_s.rjust(2) + " " 
    weekday += 1 
    if weekday % 7 == 0 
      print "\n"
    end
  end
  puts "\n"
end

if (params[:y] && params[:m]).class == Integer #-y,-m両方指定の場合
  puts "#{params[:m]}月 #{params[:y]}".center(20)
  puts weekdays
  begin
    weekday = Date.new(params[:y], params[:m]).wday 
    last_day = Date.new(params[:y], params[:m], -1).day 
  rescue Date::Error, TypeError
    puts "-mは1~12の間の値を入力してください"    
  end
  output_calender(weekday, last_day)

elsif params[:y].class == NilClass && params[:m].class == Integer #-mのみ指定の場合
  puts "#{params[:m]}月 #{today.year}".center(20)
  puts weekdays
    begin
      weekday = Date.new(today.year, params[:m]).wday 
      last_day = Date.new(today.year, params[:m], -1).day 
    rescue TypeError, Date::Error
      puts "-mは1~12の間の値を入力してください"   
    end
  output_calender(weekday, last_day)
  
else #指定なしの場合
  puts "#{today.month}月 #{today.year}".center(20)
  puts weekdays
  weekday = Date.new(today.year, today.month).wday 
  last_day = Date.new(today.year, today.month, -1).day  
  output_calender(weekday, last_day)
end

