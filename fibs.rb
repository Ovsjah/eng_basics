require 'pry'

class Fibs
  attr_accessor :generated_fibs

  def generate x
    if generated_fibs && generated_fibs.size >= x
      generated_fibs[0..x]
    else
      generate_fibs x
    end
  end

  def is_known_fib? num
    !!generated_fibs&.include?(num)
  end

  def all_fibs? seq_array
    generate_fibs(seq_array.size) == seq_array
  end

  def known_fibs_sum_of_squares
    generated_fibs&.inject { |sum, n| sum + n ** 2 }.to_i
  end

  private

  def generate_fibs x
    @generated_fibs = []

    a = 0
    b = 1
    i = 0

    until i == x
      @generated_fibs << a
      a, b = b, a + b
      i += 1
    end

    @generated_fibs
  end
end
