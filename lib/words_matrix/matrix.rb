class WordsMatrix::Matrix
  attr_reader :grid, :tokens

  def initialize(n, min_length)
    @n = n
    @min_length = min_length
    @grid = generate_grid
    parse_to_tokens!
  end

  def to_s
    grid.map do |line|
      line.join(" ")
    end.join("\n")
  end

  def words_from(x, y)
    raise ArgumentError, "Incorrect range" unless (0..@n-1).include?(x) || (0..@n-1).include?(y)
    [
      horizontal_line((y...@n).to_a, x),
      horizontal_line((0..y).to_a.reverse, x),
      vertical_line((x...@n).to_a, y),
      vertical_line((0..x).to_a.reverse, y),
      diagonal((x...@n).to_a, y),
      diagonal((0..x).to_a.reverse, y),
      diagonal((x...@n).to_a, y, -1),
      diagonal((0..x).to_a.reverse, y, -1)
    ].flatten.compact
  end

  private
  def generate_grid
    vowels = %w[A E O U I]
    consonants = ('B'..'Z').to_a - vowels

    Array.new(@n) do
      Array.new(@n) do
       (rand(4).zero? ? consonants : vowels).sample
     end
   end
  end

  def parse_to_tokens!
    @tokens = Hash.new([])

    (0...@n).each do |x|
      (0...@n).each do |y|
        words = words_from(x, y)
        @tokens[@grid[x][y]] += words if words.any?
      end
    end
  end

  def horizontal_line(y_range, x)
    return nil if invalid_range?(y_range)

    y_range.to_a.map do |yt|
      @grid[x][yt]
    end.join
  end

  def vertical_line(x_range, y)
    return nil if invalid_range?(x_range)

    x_range.to_a.map do |xt|
      @grid[xt][y]
    end.join
  end

  def diagonal(x_range, y, multiplier=1)
    return nil if invalid_range?(x_range) || !(0...@n).include?(y + multiplier*@min_length)

    x_range.to_a.map.with_index do |xt, i|
      next unless (0...@n).include? y+i*multiplier
      @grid[xt][y+i*multiplier]
    end.join
  end

  def invalid_range?(range)
    range.size < @min_length
  end
end