class WordsMatrix::Service
  attr_reader :matrix, :dictionary

  def initialize(config={})
    config = WordsMatrix::Config::DEFAULTS.merge(config)

    validate_options!(config)
    @matrix = WordsMatrix::Matrix.new(config[:n].to_i, config[:min_length].to_i)
    @dictionary = WordsMatrix::Dictionary.new(config[:min_length].to_i, config[:dict_path])

    @words = []
  end

  private
  def validate_options!(config)
    raise ArgumentError, "matrix size should be a positive integer" if config[:n].to_i < 1
    raise ArgumentError, "min word length should be a positive integer and less than matrix size" unless (0..config[:n].to_i).include?(config[:min_length].to_i)
    raise ArgumentError, "dictionary path is not a valid file path" unless File.readable?(config[:dict_path])
  end


end