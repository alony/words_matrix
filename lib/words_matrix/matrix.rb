class WordsMatrix::Matrix
  attr_reader :grid

  def initialize(n)
    @grid = generate_grid(n)
  end

  private
  def generate_grid(n)
    vowels = %w[A E O U I]
    consonants = ('B'..'Z').to_a - vowels

    Array.new(n) do
      Array.new(n) do
       (rand(4).zero? ? consonants : vowels).sample
     end
   end
  end
end