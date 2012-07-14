# coding: utf-8
require File.dirname(__FILE__) + '/lib/latex-to-unicode.rb'

puts LatexToUnicode::convert(gets.chomp)
