require File.dirname(__FILE__) + '/data.rb'
require 'treetop'
Treetop.load 'latex'

module LatexToUnicode
  PARSER = LatexParser.new
  def self.convert(str)
    PARSER.parse(translate(str, SYMBOLS)).value
  end
end

__END__
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

    { "^"       => LatexToUnicode::SUPERSCRIPTS,
      "_"       => LatexToUnicode::SUBSCRIPTS,
      "\\bb"    => LatexToUnicode::BB,
      "\\bf"    => LatexToUnicode::BF,
      "\\cal"   => LatexToUnicode::CAL,
      "\\frak"  => LatexToUnicode::FRAK,
      "\\it"    => LatexToUnicode::IT,
      "\\mono"  => LatexToUnicode::MONO
    }.each do |k, v|
      result = apply_modifier(result, k, v)
    end

    result
  end
end
