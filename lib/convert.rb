require 'treetop'
require File.dirname(__FILE__) + '/data.rb'
require File.dirname(__FILE__) + '/latex_grammar.rb'

module LatexToUnicode
  def self.convert(str)
    LatexParser.new.parse(translate(str.gsub(/\s/, ''), SYMBOLS)).value
  end
end
