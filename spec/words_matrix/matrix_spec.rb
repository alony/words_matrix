require 'spec_helper'

describe WordsMatrix::Matrix do
  let(:matrix) {WordsMatrix::Matrix.new(6, 4)}
  let(:sample_grid) {
    [
      %w[A B C D E X],
      %w[F G H I J X],
      %w[K L M N O X],
      %w[P Q R S T X],
      %w[U V W X Y X],
      %w[A B C D E X]
    ]
  }

  describe "#initialize" do
    it "should initialize grid" do
      expect(matrix.grid).not_to be_nil
    end

    it "should parse grid to tokens" do
      expect(matrix.tokens).not_to be_empty
    end
  end

  describe "#grid" do
    subject(:grid) { matrix.grid }

    its(:size) { should eq 6 }
    it "should have approximately 3 times more vowels" do
      consonants_count = subject.flatten.count {|letter| !%w[A E I O U].include?(letter)}

      expect(consonants_count).to be_within(10).of(subject.size**2 / 4)
    end
  end

  describe "#tokens" do
    before { allow_any_instance_of(WordsMatrix::Matrix).to receive(:generate_grid).and_return([["A", "B", "C"],["D", "E", "F"], ["G", "H", "I"]]) }
    let(:matrix) { WordsMatrix::Matrix.new(3, 3) }

    it "should exclude too short tokens" do
      expect(matrix.tokens.keys).not_to include("E")
    end
  end

  describe "#words_from" do
    it "should skip all combinations shorter than min_length" do
      expect(matrix.words_from(1, 0).any?{ |el| el.size < 4 }).to be false
    end

    context "letter check" do
      before do
        allow_any_instance_of(WordsMatrix::Matrix).to receive(:generate_grid).and_return(sample_grid)
      end

      it "should fetch appropriate horizontal letter combinations" do
        expect(matrix.words_from(1,4)).to include("JIHGF")
      end

      it "should fetch appropriate vertical letter combinations" do
        expect(matrix.words_from(1,4)).to include("JOTYE")
      end

      it "should fetch appropriate diagonal letter combinations" do
        expect(matrix.words_from(1,4)).to include("JNRVA")
      end

      it "should not contain any additional letter combinations" do
        expect(matrix.words_from(1,4).size).to eq 3
      end
    end
  end
end
