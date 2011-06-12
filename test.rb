# coding: utf-8
require './convert.rb'

DATA.readlines.each do |testcase|
  s, exp = testcase.split
  res = LatexToUnicode::convert(s)
  if res != exp
    puts "Error: '#{s}' gave '#{res}' instead of '#{exp}'."
  end
end

__END__
\alpha          α
\beta           β
_23             ₂3
_{23}           ₂₃
_{23}a          ₂₃a
^23             ²3
^{23}           ²³
\alpha^\alpha   αᵅ
