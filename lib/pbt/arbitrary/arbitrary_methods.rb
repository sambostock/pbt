# frozen_string_literal: true

require "pbt/arbitrary/constant"
require "pbt/arbitrary/array_arbitrary"
require "pbt/arbitrary/char_arbitrary"
require "pbt/arbitrary/integer_arbitrary"
require "pbt/arbitrary/tuple_arbitrary"
require "pbt/arbitrary/fixed_hash_arbitrary"
require "pbt/arbitrary/choose_arbitrary"
require "pbt/arbitrary/one_of_arbitrary"

module Pbt
  module Arbitrary
    module ArbitraryMethods
      # @param min [Integer]
      # @param max [Integer]
      def integer(min: nil, max: nil)
        IntegerArbitrary.new(min, max)
      end

      # @param max [Integer]
      def nat(max: nil)
        IntegerArbitrary.new(0, max)
      end

      # @param arbitrary [Arbitrary]
      # @param min [Integer]
      # @param max [Integer]
      # @param empty [Boolean]
      def array(arbitrary, min: 0, max: 10, empty: true)
        raise ArgumentError if min < 0
        min = 1 if min.zero? && !empty
        ArrayArbitrary.new(arbitrary, min, max)
      end

      # @param arbs [Array<Pbt::Arbitrary>
      def tuple(*arbs)
        TupleArbitrary.new(*arbs)
      end

      # @param hash [Hash<Symbol->Pbt::Arbitrary>]
      def fixed_hash(hash)
        FixedHashArbitrary.new(hash)
      end

      # @param range [Range<Integer>]
      def choose(range)
        ChooseArbitrary.new(range)
      end

      # @param choices [Array]
      def one_of(*choices)
        OneOfArbitrary.new(choices)
      end

      # Generates a single unicode character (including printable and non-printable).
      def char
        CharArbitrary.new
      end

      def printable_ascii_char
        one_of(*PRINTABLE_ASCII_CHARS)
      end
    end
  end
end
