# coding: utf-8
require 'test/unit'
require './lib/latex-to-unicode.rb'

class TestConverter < Test::Unit::TestCase
  def test_atoms
    # Ensure that all symbols are translated correctly
    File.open('./lib/data/symbols').readlines.each do |l|
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
    assert_equal 'α ᵅ', LatexToUnicode::convert('\alpha \; ^ \alpha')
    assert_equal 'α ᵅ', LatexToUnicode::convert('\alpha \: ^ \alpha')
    assert_equal 'α ᵅ', LatexToUnicode::convert('\alpha \, ^ \alpha')
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
    assert_equal '½', LatexToUnicode::convert('\frac {1} {2}') 
    assert_equal '⅓', LatexToUnicode::convert('\frac {1} 3')
    assert_equal '¼', LatexToUnicode::convert('\frac 1 {4}')
    assert_equal '⅕', LatexToUnicode::convert('\frac 1 5')
    assert_equal '⅙', LatexToUnicode::convert('\frac 1 6')
    assert_equal '⅛', LatexToUnicode::convert('\frac 1 8')
    assert_equal '⅔', LatexToUnicode::convert('\frac 2 3')
    assert_equal '⅖', LatexToUnicode::convert('\frac 2 5')
    assert_equal '¾', LatexToUnicode::convert('\frac 3 4')
    assert_equal '⅗', LatexToUnicode::convert('\frac 3 5')
    assert_equal '⅜', LatexToUnicode::convert('\frac 3 8')
    assert_equal '⅘', LatexToUnicode::convert('\frac 4 5')
    assert_equal '⅚', LatexToUnicode::convert('\frac 5 6')
    assert_equal '⅝', LatexToUnicode::convert('\frac 5 8')
    assert_equal '⅞', LatexToUnicode::convert('\frac 7 8')
    assert_equal '(2 / 14)', LatexToUnicode::convert('\frac 2 {14}')
    assert_equal '(α / 2)', LatexToUnicode::convert('\frac \alpha 2')
  end

  def test_sqrt
    assert_equal '√(2)', LatexToUnicode::convert('\sqrt[2] 2')
    assert_equal '√(2)', LatexToUnicode::convert('\sqrt 2')
    assert_equal '∛(2)', LatexToUnicode::convert('\sqrt[3] 2')
    assert_equal '∜(2)', LatexToUnicode::convert('\sqrt[4] 2')
    assert_equal 'ᵃ√(3)', LatexToUnicode::convert('\sqrt[a]3')
    assert_equal '√(28)', LatexToUnicode::convert('\sqrt {28}')
  end

  def test_combining
    assert_equal 'â', LatexToUnicode::convert('\hat{a}')
    assert_equal 'â', LatexToUnicode::convert('\hata')
    assert_equal 'âb', LatexToUnicode::convert('\hatab')
    assert_equal 'Â', LatexToUnicode::convert('\hatA')

    assert_equal 'ă', LatexToUnicode::convert('\breve{a}')
    assert_equal 'à', LatexToUnicode::convert('\grave{a}')
    assert_equal 'ā', LatexToUnicode::convert('\bar{a}')
    assert_equal 'ǎ', LatexToUnicode::convert('\check{a}')
    assert_equal 'á', LatexToUnicode::convert('\acute{a}')
    assert_equal 'ã', LatexToUnicode::convert('\tilde{a}')
    assert_equal 'a⃗', LatexToUnicode::convert('\vec{a}')
    assert_equal 'ȧ', LatexToUnicode::convert('\dot{a}')
    assert_equal 'ä', LatexToUnicode::convert('\ddot{a}')
    assert_equal 'å', LatexToUnicode::convert('\mathring{a}')
  end

  def test_subset
    assert_equal '∅≠S⊊V', LatexToUnicode::convert('\emptyset \neq S \subsetneq V')
    assert_equal 'A⊂B⊆C⊊D⊋E⊇F⊃G', LatexToUnicode::convert('A \subset B \subseteq C \subsetneq D \supsetneq E \supseteq F \supset G');
  end

  def test_actual_data
    assert_equal '2⁺₂k3', LatexToUnicode::convert('2^+_2k3')
    assert_equal 'α₃', LatexToUnicode::convert('\alpha_3')
    assert_equal 'ᵅ', LatexToUnicode::convert('^\alpha')
    assert_equal 'ᵝ', LatexToUnicode::convert('^\beta')
    assert_equal 'x₄+y₆', LatexToUnicode::convert('x_{4} + y_{6}')
    assert_equal 'x₄+y₆', LatexToUnicode::convert('x_4 + y_6')
    assert_equal '(2 / 31)', LatexToUnicode::convert('\frac{2}{31}')
    assert_equal '(2 / 31)', LatexToUnicode::convert('\dfrac{2}{31}')
    assert_equal 'α⋅u', LatexToUnicode::convert('\alpha \cdot u')
    assert_equal '∂𝕦', LatexToUnicode::convert('\partial \mathbb u')
    assert_equal 'α⁶⁷', LatexToUnicode::convert('\alpha^{67}')
    assert_equal 'n₂', LatexToUnicode::convert('n_2')
    assert_equal 'α²⋅α²⁺³≡α⁷', LatexToUnicode::convert('\alpha^2 \cdot \alpha^{2+3} \equiv \alpha^7')
    assert_equal '∇²∂αβγ', LatexToUnicode::convert('\nabla^2\partial\alpha\beta\gamma')
    assert_equal '𝓪', LatexToUnicode::convert('\mathcala')
    assert_equal '𝐚', LatexToUnicode::convert('\mathbfa')
    assert_equal 'αᵝ', LatexToUnicode::convert('\alpha^ \beta')
    assert_equal 'αᵝ', LatexToUnicode::convert('\alpha^\beta')
    assert_equal 'L₁⊂L₂⇒∀w∈L₁,w∈L₂', LatexToUnicode::convert('L_1 \subset L_2 \Rightarrow \forall w \in L_1, w \in L_2')
    assert_equal 'Z=∑jgje⁻ᵝᴱʲ', LatexToUnicode::convert('Z=\sum_{j}g_{j}e^{-\beta E_{j}}')
    assert_equal '𝐴∈ℝⁿˣⁿ,𝐯∈ℝⁿ,λᵢ∈ℝ:𝐴𝐯=λᵢ𝐯', LatexToUnicode::convert('\itA \in \bbR^{nxn}, \bfv \in \bbR^n, \lambda_i \in \bbR: \itA\bfv = \lambda_i\bfv')
    assert_equal '∫xdx', LatexToUnicode::convert('\int x dx')
    assert_equal 'α₁₂₃∈𝔊', LatexToUnicode::convert('\alpha_{123} \in \frak{G}')
    assert_equal 'α₁₂₃∈𝔖', LatexToUnicode::convert('\alpha_{123} \in \mathfrak{S}')
    assert_equal '∫⌈Γ(x)⌉dx', LatexToUnicode::convert('\int \lceil \Gamma(x) \rceil dx')
    assert_equal '∫〈Γ(x)〉dx', LatexToUnicode::convert('\int \langle \Gamma(x) \rangle dx')
    assert_equal 'm:I→H\':H\'⊆H,p(I,H\',Nf).', LatexToUnicode::convert('m : I \rightarrow { H\' : H\' \subseteq H, p(I, H\', N_{f}) }.')
  end
end
