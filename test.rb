# coding: utf-8
require './convert.rb'

DATA.readlines.each do |testcase|
  s, exp = testcase.split
  if convert(s) == exp
    print '*'
  else
    puts "Error: '#{s}' gave '#{convert(s)}' instead of '#{exp}'."
  end
end

puts

__END__
\alpha α
\beta β
