require 'treetop'
require File.dirname(__FILE__) + '/data.rb'
Treetop.load File.dirname(__FILE__) + '/latex.treetop'

module LatexToUnicode
  def self.convert(str)
    LatexParser.new.parse(translate(str.gsub(/\s/, ''), SYMBOLS)).value
  end
end
