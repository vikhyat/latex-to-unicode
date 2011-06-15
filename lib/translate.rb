# coding: utf-8

module LatexToUnicode
  def self.translate(str, set)
    q = str.dup
    set.each do |k, v|
      q.gsub!(k, v)
    end
    q
  end

  def self.translate_fraction(num, den)
    case [num.to_i, den.to_i]
    when [1, 2] then '½'
    when [1, 3] then '⅓'
    when [1, 4] then '¼'
    when [1, 5] then '⅕'
    when [1, 6] then '⅙'
    when [1, 8] then '⅛'
    when [2, 3] then '⅔'
    when [2, 5] then '⅖'
    when [3, 4] then '¾'
    when [3, 5] then '⅗'
    when [3, 8] then '⅜'
    when [4, 5] then '⅘'
    when [5, 6] then '⅚'
    when [5, 8] then '⅝'
    when [7, 8] then '⅞'
    else
      "(#{num} / #{den})"
    end
  end
end
