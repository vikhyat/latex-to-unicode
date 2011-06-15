# coding: utf-8

task :default => [:process_data]

task :process_data do
  File.open('./data.rb', 'w') do |f|
    f.puts "# coding: utf-8"
    f.puts
    f.puts "module LatexToUnicode"
    %w[subscripts superscripts symbols bb bf cal frak it mono].map do |d|
      data = 
      f.puts "  #{d.upcase} = {"
      f.puts File.readlines("./data/#{d}").sort.reverse.map {|l|
        "    #{l.split[0].inspect} => #{l.split[1].inspect}"
      }.join(",\n")
      f.puts "  }"
    end
    f.puts "end"
  end
end
