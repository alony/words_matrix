# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'words_matrix'

Gem::Specification.new do |spec|
  spec.name          = "words_matrix"
  spec.version       = WordsMatrix::VERSION
  spec.authors       = ["Alona Mekhovova"]
  spec.email         = ["alona.tarasova@gmail.com"]
  spec.summary       = "Words search in a random letter matrix"
  spec.description   = %q{
    A command line app able to generate a random word search grid n x n (n: number of rows/number of columns) and find all the words inside it.

    - The grid letters must be uppercase.
    - The valid words are defined inside the file dict.txt
    - The minimum size of a valid word is 3 characters.
    - The program must detect all possible directions: horizontal, vertical and diagonal.

    (The words can be on reverse order)
  }
  spec.homepage      = "https://github.com/alony/words_matrix"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["words_matrix"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "data"]

  spec.add_runtime_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
end
