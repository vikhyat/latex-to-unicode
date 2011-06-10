require './data'

# If ch is in d.keys, return d[ch], otherwise return ch.
def translate_if_possible(ch, d)
  d[ch].nil? ? ch : d[ch]
end

def convert_superscripts(s)
  ss = ""
  mode = :normal
  # TODO: refactor code below
  s.each_char do |ch|
    if mode == :normal and ch == "^"
      mode = :caret
      next
    elsif mode == :caret and ch == "{"
      mode = :long
      next
    elsif mode == :caret
      ss << translate_if_possible(ch, $latex_superscripts)
      mode = :normal
      next
    elsif mode == :long and ch == "}"
      mode = :normal
      next
    end

    if mode == :normal
      ss << ch
    else
      ss << translate_if_possible(ch, $latex_superscripts)
    end
  end

  ss
end

def convert(s)
  ss = s.dup

  # Replace all latex symbols (alpha, beta, etc.) with the appropriate unicode
  # characters.
  $latex_symbols.each do |latex, unicode|
    ss.gsub!(latex, unicode)
  end

  ss = convert_superscripts(ss)

  ss
end
