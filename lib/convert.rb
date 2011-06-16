require 'treetop'
require File.dirname(__FILE__) + '/data.rb'
require File.dirname(__FILE__) + '/latex_grammar.rb'

module LatexToUnicode
  def self.preprocess(str)
    translate(str.gsub(/\s/, ''), SYMBOLS)
  end
  def self.convert(str)
    LatexParser.new.parse(preprocess(str)).value
  end
end
