# coding: utf-8
require 'test/unit'
require 'treetop'

Treetop.load 'latex'

class TestParser < Test::Unit::TestCase
  def setup
    @parser = LatexParser.new
  end

  def test_atoms
    # Ensure that all symbols are translated correctly
    File.open('./data/symbols').readlines.each do |l|
      sym, res = l.split
      assert_equal res, @parser.parse(sym).value
    end
  end

  def test_superscripts
    assert_equal "²3", @parser.parse("^23").value
    assert_equal "²³", @parser.parse("^{23}").value
    assert_equal "αᵅ", @parser.parse("\alpha^\alpha").value
  end
end
