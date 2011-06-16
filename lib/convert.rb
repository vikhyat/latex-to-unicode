require 'treetop'
require File.dirname(__FILE__) + '/data.rb'
require File.dirname(__FILE__) + '/latex_grammar.rb'

module LatexToUnicode
  def self.preprocess(str)
    str = str.gsub(/\s/, '')
    str = translate(str, SYMBOLS)
    str = translate(str, ALIASES)
  end
  def self.convert(str)
    LatexParser.new.parse(preprocess(str)).value
  end
end
