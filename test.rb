# coding: utf-8
require 'test/unit'
require './lib/convert.rb'

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

  def test_whitespace
    assert_equal 'αᵅ', LatexToUnicode::convert('\alpha ^ \alpha')
  end

  def test_subscripts
    assert_equal '₂3', LatexToUnicode::convert('_23')
    assert_equal '₂₃', LatexToUnicode::convert('_{23}')
    assert_equal '₂₃a', LatexToUnicode::convert('_{23}a')
    assert_equal 'αᵨ', LatexToUnicode::convert('\alpha_\rho')
  end

  def test_fonts
    assert_equal '𝔸𝕓c', LatexToUnicode::convert('\bb{Ab}c')
    assert_equal '𝐀𝐛c', LatexToUnicode::convert('\bf{Ab}c')
    assert_equal '𝓐𝓫c', LatexToUnicode::convert('\cal{Ab}c')
    assert_equal '𝔄𝔟c', LatexToUnicode::convert('\frak{Ab}c')
    assert_equal '𝐴𝑏c', LatexToUnicode::convert('\it{Ab}c')
    assert_equal '𝙰𝚋c', LatexToUnicode::convert('\mono{Ab}c')
  end

  def test_frac
    assert_equal "½", LatexToUnicode::convert('\frac {1} {2}') 
    assert_equal "⅓", LatexToUnicode::convert('\frac {1} 3')
    assert_equal "¼", LatexToUnicode::convert('\frac 1 {4}')
    assert_equal "⅕", LatexToUnicode::convert('\frac 1 5')
    assert_equal "⅙", LatexToUnicode::convert('\frac 1 6')
    assert_equal "⅛", LatexToUnicode::convert('\frac 1 8')
    assert_equal "⅔", LatexToUnicode::convert('\frac 2 3')
    assert_equal "⅖", LatexToUnicode::convert('\frac 2 5')
    assert_equal "¾", LatexToUnicode::convert('\frac 3 4')
    assert_equal "⅗", LatexToUnicode::convert('\frac 3 5')
    assert_equal "⅜", LatexToUnicode::convert('\frac 3 8')
    assert_equal "⅘", LatexToUnicode::convert('\frac 4 5')
    assert_equal "⅚", LatexToUnicode::convert('\frac 5 6')
    assert_equal "⅝", LatexToUnicode::convert('\frac 5 8')
    assert_equal "⅞", LatexToUnicode::convert('\frac 7 8')
    assert_equal "(2 / 14)", LatexToUnicode::convert('\frac 2 {14}')
    assert_equal "(α / 2)", LatexToUnicode::convert('\frac \alpha 2')
  end

  def test_sqrt
    assert_equal "√(2)", LatexToUnicode::convert('\sqrt[2] 2')
    assert_equal "√(2)", LatexToUnicode::convert('\sqrt 2')
    assert_equal "∛(2)", LatexToUnicode::convert('\sqrt[3] 2')
    assert_equal "∜(2)", LatexToUnicode::convert('\sqrt[4] 2')
    assert_equal "ᵃ√(3)", LatexToUnicode::convert('\sqrt[a]3')
    assert_equal "√(28)", LatexToUnicode::convert('\sqrt {28}')
  end
end
