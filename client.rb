# coding: utf-8
require File.dirname(__FILE__) + '/lib/convert.rb'

def replace(input, pair1, pair2)
  output  = []
  rem     = input.split('')
  in_flag = false
  buffer  = []
  while rem.length > 0
    if in_flag
      if rem[0] == pair2[0] and rem[1] == pair2[1]
        rem.shift(2)
        in_flag = false
        output.push LatexToUnicode::convert(buffer.join)
        buffer = []
      else
        buffer.push rem.shift
      end
    else
      if rem[0] == pair1[0] and rem[1] == pair1[1]
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
