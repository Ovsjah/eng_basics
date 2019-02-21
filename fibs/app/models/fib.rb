class Fib < ApplicationRecord
  serialize :generated_fibs
  before_save :generate

  validates :size, presence: true, numericality: {only_integer: true}

  def generate
    already_generated || generate_fibs(size)
  end

  def is_known_fib?(num)
    !!generated_fibs&.include?(num)
  end

  def all_fibs?(seq_array)
    generate_fibs(seq_array.size) == seq_array
  end

  def known_fibs_sum_of_squares
    generated_fibs&.inject { |sum, n| sum + n ** 2 }.to_i
  end

  private

  class << self
    def find_generated_fibs(size)
      find_by("size >= ?", size)&.generated_fibs&.slice(0, size)
    end
  end

  def generate_fibs(x)
    self.generated_fibs = []

    a = 0
    b = 1

    loop do
      return generated_fibs if generated_fibs.size == x
      generated_fibs << a
      a, b = b, a + b
    end
  end

  def already_generated
    self.generated_fibs = self.class.find_generated_fibs(size)
  end
end
