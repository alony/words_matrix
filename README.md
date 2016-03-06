# WordsMatrix

Words search in a random letter matrix


A command line app able to generate a random word search grid n x n (n: number of rows/number of columns) and find all the words inside it.

- The grid letters must be uppercase.
- The valid words are defined inside the file dict.txt
- The minimum size of a valid word is 3 characters.
- The program must detect all possible directions: horizontal, vertical and diagonal.

(The words can be on reverse order)

## Installation

Add this line to your application's Gemfile:

    gem 'words_matrix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install words_matrix

## Usage

    words_matrix search

    Options:
      [-n=N]                               # Size of letter grid. Optional, default is 10.
      [--min-length=N]                     # Minimum word length. Optional, default is 3.
      [--dictionary-path=DICTIONARY_PATH]  # A path to dictionary with words, in case some external dictionary should be used. Internal dictionary is used by default.

All the options are optional. Example usage with options:

`words_matrix search -n=6 --min_length=4 --dictionary_path='spec/fixtures/test_dict.txt'`

Sample output:

      words_matrix alona.mekhovova$ words_matrix search -n=6

      Letter grid created. Searching for words.
      Matrix:
      U E C O A E
      P E E O Z A
      A G M V U O
      U Z T A I U
      Q U A I O A
      E E I O I A

      Words found:
      OVA <ovum=n> [n]
      AZO containing nitrogen [adj]
      AVO a monetary unit of Macao [n AVOS]
      PEE to urinate -- sometimes considered vulgar [v PEED, PEEING, PEES]
      GEE to turn to the right [v GEED, GEEING, GEES]
      MOA an extinct flightless bird [n -S]
      VEE the letter V [n -S]
      QUA in the capacity of [adv]
      QUAI {quay=n} [n -S]