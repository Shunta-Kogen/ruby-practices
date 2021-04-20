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
