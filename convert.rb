require File.dirname(__FILE__) + '/data.rb'

module LatexToUnicode
  # If ch is in d.keys, return d[ch], otherwise return ch.
  def self.translate_if_possible(ch, d)
    d[ch].nil? ? ch : d[ch]
  end

  def self.convert(s)
    s1 = s.dup

    # Replace all latex symbols (alpha, beta, etc.) with the appropriate unicode
    # characters.
    LatexToUnicode::SYMBOLS.each do |latex, unicode|
      s1.gsub!(latex, unicode)
    end

    # Convert superscripts and subscripts.
    # TODO: make this more robust
    s2 = ""
    mode = :short
    type = :normal
    s1.each_char do |ch|
      if ch == "{"
        mode = :long; next
      elsif ch == "}"
        mode = :short; type = :normal; next
      elsif ch == "^"
        type = :super; next
      elsif ch == "_"
        type = :sub; next
      end

      if type == :super
        s2 << translate_if_possible(ch, LatexToUnicode::SUPERSCRIPTS)
        type = :regular if mode == :short
      elsif type == :sub
        s2 << translate_if_possible(ch, LatexToUnicode::SUBSCRIPTS)
        type = :regular if mode == :short
      else
        s2 << ch
      end
    end

    s2
  end
end
