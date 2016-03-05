class WordsMatrix::Service
  attr_reader :matrix, :dictionary, :words

  def initialize(config={})
    config = WordsMatrix::Config::DEFAULTS.merge(config)

    validate_options!(config)
    @matrix = WordsMatrix::Matrix.new(config[:n].to_i, config[:min_length].to_i)
    @dictionary = WordsMatrix::Dictionary.new(config[:min_length].to_i, config[:n].to_i, config[:dict_path])

    @words = []
  end

  def find_words
    @matrix.tokens.each_pair do |letter, tokens|
      next unless @dictionary.words.has_key?(letter)
      words = @dictionary.words[letter].keys

      tokens.each do |token|
        words_found = words.select { |word| token =~ /^#{word}.*/ }

        @words += words_found.map { |word| @dictionary.words[letter][word] }
      end
    end
    @words.uniq!
  end

  def to_s
    words_found = @words.any? ? @words.join("\n") : "none :("
    ["Matrix:",
      matrix.to_s,
      "",
      "Words found:",
      words_found].join("\n")
  end

  private
  def validate_options!(config)
    raise ArgumentError, "matrix size should be a positive integer" if config[:n].to_i < 1
    raise ArgumentError, "min word length should be a positive integer and less than matrix size" unless (0..config[:n].to_i).include?(config[:min_length].to_i)
    raise ArgumentError, "dictionary path is not a valid file path" unless File.readable?(config[:dict_path])
  end
end