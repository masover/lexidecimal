require 'bigdecimal'

module Lexidecimal
  MINUS = '-'.freeze
  PLUS = '+'.freeze
  
  def self.invert string
    string.each_char.map{|d| 9-d.to_i}.join
  end
  
  def self.num_to_string num
    unless num.kind_of? BigDecimal
      num = BigDecimal.new(num.to_s)
    end
    
    sign, digits, base, exponent = num.split
    if sign < 1
      digits = self.invert digits
      sign = MINUS
      antisign = PLUS
    else
      sign = PLUS
      antisign = MINUS
    end
    
    if exponent < 0
      exp_sign = MINUS * (Math.log10(-exponent).floor+1)
      exponent = self.invert exponent.to_s
    else
      exp_sign = PLUS * (Math.log10(exponent).floor+1)
      exponent = exponent.to_s
    end
    
    "#{sign}#{exp_sign}#{exponent}#{digits}#{antisign}"
  end
end