require File.dirname(__FILE__) + '/data.rb'

module LatexToUnicode
  # If ch is in d.keys, return d[ch], otherwise return ch.
  def self.translate_if_possible(ch, d)
    d[ch].nil? ? ch : d[ch]
  end

  # for example, (modifier="^", set = LatexToUnicode::superscripts) will
  # take care of superscripts in s.
  def self.apply_modifier(s, modifier, set)
    s = s.gsub(modifier, "^")
    result = ""
    mode = :normal # normal, long, mod
    s.each_char do |ch|
      if mode == :normal
        if ch == "^"
          mode = :mod; next
        else
          result << ch; next
        end
      elsif mode == :mod
        if ch == "{"
          mode = :long; next
        else
          result << translate_if_possible(ch, set)
          mode = :normal; next
        end
      elsif mode == :long
        if ch == "}"
          mode = :normal; next
        else
          result << translate_if_possible(ch, set)
        end
      end
    end
    result
  end

  def self.convert(s)
    result = s.dup

    # Replace all latex symbols (alpha, beta, etc.) with the appropriate unicode
    # characters.
    LatexToUnicode::SYMBOLS.each do |latex, unicode|
      result.gsub!(latex, unicode)
    end

    result = apply_modifier(result, "^", LatexToUnicode::SUPERSCRIPTS)
    result = apply_modifier(result, "_", LatexToUnicode::SUBSCRIPTS)
    result = apply_modifier(result, "\\bb", LatexToUnicode::BB)
    result = apply_modifier(result, "\\bf", LatexToUnicode::BF)
    
    result
  end
end
