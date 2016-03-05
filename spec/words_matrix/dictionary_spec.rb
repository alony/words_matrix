require 'spec_helper'

describe WordsMatrix::Dictionary do
  let(:dict_path) {'spec/fixtures/test_dict.txt'}
  let(:subject) {WordsMatrix::Dictionary.new(6, dict_path)}

  describe "#initialize" do
    its(:words) { should_not be_nil }

    it "should save only words of required length" do
      expect(subject.words.keys).to eq ["P"]
    end

    context "file unreadable" do
      it "should raise an error" do
        expect{ WordsMatrix::Dictionary.new(15, "inexisting path")}.to raise_error(IOError, /error while reading dictionary file: No such file or directory/)
      end
    end
  end
end
