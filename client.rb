# coding: utf-8
require File.dirname(__FILE__) + '/lib/convert.rb'

def compare(rem, pr)
  pr.split('').each.with_index do |x, i|
    return false if x != rem[i]
  end
  return true
end

def replace(input, pair1, pair2)
  output  = []
  rem     = input.split('')
  in_flag = false
  buffer  = []
  while rem.length > 0
    if in_flag
      if compare(rem[0], pair2)
        rem.shift(2)
        in_flag = false
        output.push LatexToUnicode::convert(buffer.join)
        buffer = []
      else
        buffer.push rem.shift
      end
    else
      if compare(rem, pair1)
        rem.shift(2)
        in_flag = true
      else
        output.push rem.shift
      end
    end
  end
  output.join
end

if ARGV[0] == "-f"
  input   = File.read(ARGV[1])
  output  = replace(input, '\\(', '\\)')
  output  = replace(output, "$$", "$$")
  output  = replace(output, "$", "$")
  puts output
else
  puts LatexToUnicode::convert(gets.chomp)
end
