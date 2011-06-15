# coding: utf-8
require 'test/unit'
require './convert.rb'

Treetop.load 'latex'

class TestConverter < Test::Unit::TestCase
  def test_atoms
    # Ensure that all symbols are translated correctly
    File.open('./data/symbols').readlines.each do |l|
      sym, res = l.split
      assert_equal res, LatexToUnicode::convert(sym)
    end
  end

  def test_superscripts
    assert_equal "²3", @parser.parse("^23").value
    assert_equal "²³", @parser.parse("^{23}").value
    assert_equal "²³a", @parser.parse("^{23}a").value
    assert_equal "αᵅ", @parser.parse("\alpha^\alpha").value
  end
end
