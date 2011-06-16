require 'treetop'
require File.dirname(__FILE__) + '/data.rb'
require File.dirname(__FILE__) + '/latex_grammar.rb'

module LatexToUnicode
  def self.preprocess(str)
    str = str.gsub(/\s/, '')
    str = translate(str, ALIASES)
    str = translate(str, SYMBOLS)
  end
  def self.convert(str)
    m = LatexParser.new.parse(preprocess(str))
    if m
      m.value
    else
      raise ArgumentError, "Parsing failed."
    end
  end
end
