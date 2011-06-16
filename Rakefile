# coding: utf-8

task :default => [:process_data, :compile_treetop, :test]

task :process_data do
  File.open('./lib/data.rb', 'w') do |f|
    f.puts "# coding: utf-8"
    f.puts
    f.puts "module LatexToUnicode"
    Dir.glob('./data/*').sort.each do |d|
      f.puts "  #{d.split('/').last.upcase} = {"
      f.puts File.readlines(d).sort.reverse.map {|l|
        "    #{l.split[0].inspect} => #{l.split[1].inspect}"
      }.join(",\n")
      f.puts "  }"
    end
    f.puts "end"
  end
end

task :compile_treetop do
  system('tt lib/latex.treetop -o lib/latex_grammar.rb')
end

task :test do
  ruby "./test.rb"
end
