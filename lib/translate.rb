module LatexToUnicode
  def self.translate(str, set)
    q = str.dup
    set.each do |k, v|
      q.gsub!(k, v)
    end
    q
  end
end
