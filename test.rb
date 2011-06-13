# coding: utf-8
require File.dirname(__FILE__) + '/convert.rb'

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
\bb{Ab}c        𝔸𝕓c
\bf{Ab}c        𝐀𝐛c
\cal{Ab}c       𝓐𝓫c
\frak{Ab}c      𝔄𝔟c
