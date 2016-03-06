module WordsMatrix::Config
  DEFAULTS = {
    n: 10,
    min_length: 3,
    dict_path: "#{File.dirname(__FILE__)}/../../data/dict.txt"
  }
end