def generate_assoc(name, data)
  str = "#{name} = {\n"
  str << data.map {|s| "  #{s[0].inspect} => #{s[1].inspect}" }.join(",\n")
  str << "\n}\n"
end

puts "# coding: utf-8"
puts
puts "module LatexToUnicode"
%w[subscripts superscripts symbols bb bf cal frak it mono].map do |f|
  data = File.new("./data/#{f}").readlines.map {|l| l.split }
  puts generate_assoc("#{f.upcase}", data.sort_by {|k| k[0] }.reverse)
end
puts "end"
