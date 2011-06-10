# coding: utf-8
require './convert.rb'

DATA.readlines.each do |testcase|
  s, exp = testcase.split
  if convert(s) != exp
    puts "Error: '#{s}' gave '#{convert(s)}' instead of '#{exp}'."
  end
end

puts

__END__
\alpha    α
\beta     β
_23       ₂3
_{23}     ₂₃
^23       ²3
^{23}     ²³
