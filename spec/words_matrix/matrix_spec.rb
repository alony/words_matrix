require 'spec_helper'

describe WordsMatrix::Matrix do
  let(:matrix) {WordsMatrix::Matrix.new(10)}

  describe "#initialize" do
    it "should initialize grid" do
      expect(matrix.grid).not_to be_nil
    end
  end

  describe "#grid" do
    subject(:grid) { matrix.grid }

    its(:size) { should eq 10 }
    it "should have approximately 3 times more vowels" do
      consonants_count = subject.flatten.count {|letter| !%w[A E I O U].include?(letter)}

      expect(consonants_count).to be_within(10).of(subject.size**2 / 4)
    end
  end
end
