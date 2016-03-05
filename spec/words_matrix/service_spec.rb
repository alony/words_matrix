require 'spec_helper'

describe WordsMatrix::Service do
  describe "#initialize" do
    context "no local options given" do
      let(:service) { WordsMatrix::Service.new }

      it "should use default options" do
        expect(service.matrix.grid.size).to eq WordsMatrix::Config::DEFAULTS[:n]
        expect(service.matrix.instance_variable_get(:"@min_length")).to eq WordsMatrix::Config::DEFAULTS[:min_length]
        expect(service.dictionary.instance_variable_get(:"@dict_path")).to eq WordsMatrix::Config::DEFAULTS[:dict_path]
      end
    end

    context "local options given" do
      let(:local_options) { {n: 5, dict_path: 'spec/fixtures/test_dict.txt', min_length: 4} }
      it "should use local options with higher priority" do
        service = WordsMatrix::Service.new(local_options)

        expect(service.matrix.grid.size).to eq local_options[:n]
        expect(service.matrix.instance_variable_get(:"@min_length")).to eq local_options[:min_length]
        expect(service.dictionary.instance_variable_get(:"@dict_path")).to eq local_options[:dict_path]
      end

      context "invalid options" do
        it "should validate the matrix size" do
          local_options[:n] = double("something weird", to_i: 0)
          expect{ WordsMatrix::Service.new(local_options) }.to raise_error(ArgumentError, "matrix size should be a positive integer")
        end

        it "should validate the min word size" do
          local_options[:min_length] = 35
          expect{ WordsMatrix::Service.new(local_options) }.to raise_error(ArgumentError, "min word length should be a positive integer and less than matrix size")
        end

        it "should check if dictionary file exists" do
          local_options[:dict_path] = 'no file here'
          expect{ WordsMatrix::Service.new(local_options) }.to raise_error(ArgumentError, "dictionary path is not a valid file path")
        end
      end
    end
  end

  describe "#find_words" do
    let(:sample_grid) {
      [
        %w[A B C D E X],
        %w[F B L I M P],
        %w[K L M N O S],
        %w[P Q R S T X],
        %w[U V W A Y X],
        %w[A B C D E X]
      ]
    }
    let(:service) { WordsMatrix::Service.new(n: 6, min_length: 4) }

    before { allow_any_instance_of(WordsMatrix::Matrix).to receive(:generate_grid).and_return(sample_grid) }

    it "should find all words not shorter than 4 chars" do
      expected_result = [
        "BLIMP a nonrigid aircraft [n -S] : BLIMPISH [adj]",
        "DINS <din=v> [v]",
        "EARL a British nobleman [n -S]",
        "LIMP lacking rigidity [adj LIMPER, LIMPEST] / to walk lamely [v -ED, -ING, -S]",
        "TOME a large book [n -S]"]
      service.find_words

      expect(service.words).to eq(expected_result)
    end
  end

  describe "#to_s" do
    let(:service) { WordsMatrix::Service.new(n: 6, min_length: 4, dict_path: 'spec/fixtures/test_dict.txt') }

    before { service.find_words }

    it "should print the matrix content" do
      expect( service.to_s ).to include(service.matrix.to_s)
    end

    it "should print the words found" do
      expect(service.to_s).to include(service.words.join("\n"))
    end

    context "no words found" do
      it "should print a related message" do
        allow(service).to receive(:words).and_return([])

        expect(service.to_s).to include("Words found:\nnone :(")
      end
    end
  end
end
