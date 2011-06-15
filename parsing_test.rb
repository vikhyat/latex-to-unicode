# coding: utf-8
require 'test/unit'
require 'treetop'

Treetop.load 'latex'

class TestParser < Test::Unit::TestCase
  def setup
    @parser = LatexParser.new
  end
  def test_atoms
    assert_equal "≥", @parser.parse('\ge').value
    assert_equal "∫", @parser.parse('\int').value
    assert_equal "α", @parser.parse('\alpha').value
  end
end
