# frozen_string_literal: true

# Class for calculating most efficient spending for stamps with given budget
class Stamps
  attr_accessor :price, :stamp1, :stamp2, :five_s, :three_s
  def initialize(price)
    @price = price
    @stamp1 = 3
    @stamp2 = 5
    @five_s = five_s
    @three_s = three_s

    validate
    calculate
    print_check
    print
  end

  # Method for input parameter validation
  def validate
    (raise ArgumentError, 'Wrong number of arguments, expected 1' if ARGV.length != 1)
    (raise IndexError, 'Input parameter has to be a natural number' unless /\A\d+\z/.match(@price))
    (raise IndexError, 'Minimal price is 8 cents' if @price.to_i < 8)
  end

  # Method for solving the problem based on linear equation
  def calculate
    y = 0
    x = 0.1
    while x % 1 != 0
      x = (@price.to_f - @stamp1.to_f * y) / @stamp2.to_f
      y += 1
    end
    y -= 1
    @stamp1 = y.round(0).to_s   # 3 cent stamps
    @stamp2 = x.round(0).to_s   # 5 cent stamps
  end

  # Method for building gramatically correct sentences in Latvian language
  def print_check
    @five_s = "#{@stamp2} piecu centu markas"
    @three_s = "#{@stamp1} trīs centu markas"
    if @stamp2 == '1' || @stamp2.end_with?('1') && !@stamp2.end_with?('11')
      @five_s = "#{@stamp2} piecu centu marka"
    end
    if @stamp1 == '1' || @stamp1.end_with?('1') && !@stamp1.end_with?('11')
      @three_s = "#{@stamp1} trīs centu marka"
    end
  end

  # Method for printing the result with print_check assigned values
  def print
    if @stamp2 == '0'
      puts "#{@three_s}."
    elsif @stamp1 == '0'
      puts "#{@five_s}."
    else
      puts "#{@five_s}, #{@three_s}."
    end
  end
end

Stamps.new(ARGV[0])
