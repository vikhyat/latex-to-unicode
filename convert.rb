require './data'

def convert(s)
  ss = s.dup
  $latex_symbols.each do |latex, unicode|
    ss.gsub!(latex, unicode)
  end

  ss
end
