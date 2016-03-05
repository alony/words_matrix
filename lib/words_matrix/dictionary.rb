class WordsMatrix::Dictionary
  attr_reader :words

  def initialize(min_length, dict_path)
    @dict_path = dict_path
    @words = read_content(min_length)
  end

  private
  def read_content(min_length)
    contents = File.read(@dict_path).split("\n")

    contents.inject(Hash.new) do |result, word_line|
      word = word_line[/^\S+/].to_s.upcase

      if word.length >= min_length
        result[word[0]] ||= {}
        result[word[0]][word] = word_line
      end
      result
    end
  rescue SystemCallError => e
    raise IOError, "error while reading dictionary file: #{e.message}"
  end
end