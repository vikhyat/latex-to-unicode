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
    assert_equal '²3', LatexToUnicode::convert('^23')
    assert_equal '²³', LatexToUnicode::convert('^{23}')
    assert_equal '²³a', LatexToUnicode::convert('^{23}a')
    assert_equal 'αᵅ', LatexToUnicode::convert('\alpha^\alpha')
  end
end
