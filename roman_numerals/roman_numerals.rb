module Roman
  refine Fixnum do
    def to_roman
      RomanNumerals.instance.to_roman(self)
    end
  end
end

require 'singleton'
class RomanNumerals
  include Singleton

  ROMAN_NUMERALS = {
       1 => 'I',
       5 => 'V',
      10 => 'X',
      50 => 'L',
     100 => 'C',
     500 => 'D',
    1000 => 'M'
  }

  SUBTRACTIVE_ROMAN = {
    'DCCCC' => 'CM',  # 900
    'CCCC'  => 'CD',  # 400
    'LXXXX' => 'XC',  # 90
    'XXXX'  => 'XL',  # 40
    'VIIII' => 'IX',  # 9
    'IIII'  => 'IV'   # 4
  }

  def to_roman(number)
    to_subtractive_roman(to_additive_roman(number))
  end

  def to_additive_roman(number)
    result = ''
    ROMAN_NUMERALS.keys.reverse.reduce(number) {|to_be_converted, base_10_value|
      num_chars_needed, remainder = to_be_converted.divmod(base_10_value)
      result << ROMAN_NUMERALS[base_10_value] * num_chars_needed
      remainder
    }
    result
  end

  def to_subtractive_roman(full_roman)
    SUBTRACTIVE_ROMAN.keys.reduce(full_roman) {|roman, long_form|
      roman.gsub(/#{long_form}/, SUBTRACTIVE_ROMAN[long_form])
    }
  end
end
