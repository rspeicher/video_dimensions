# https://github.com/mynyml/unindent
class String
  def unindent
    indent = self.split("\n").select {|line| !line.strip.empty? }.map do |line|
      line.index(/[^\s]/)
    end.compact.min || 0

    self.gsub(/^[[:blank:]]{#{indent}}/, '')
  end
end
