class WordsMatrix::Dictionary
  attr_reader :words

  def initialize(min_length, max_length, dict_path)
    @dict_path = dict_path
    @words = read_content(min_length, max_length)
  end

  private
  def read_content(min_length, max_length)
    contents = File.read(@dict_path).split("\n")

    result = {}

    contents.each do |word_line|
      word = word_line[/^\S+/].to_s.upcase

      break if word.length > max_length
      if word.length >= min_length
        result[word[0]] ||= {}
        result[word[0]][word] = word_line
      end
    end

    result
  rescue SystemCallError => e
    raise IOError, "error while reading dictionary file: #{e.message}"
  end
end