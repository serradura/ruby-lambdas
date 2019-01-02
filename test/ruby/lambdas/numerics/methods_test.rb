require "test_helper"

class RubyLambdasNumericsMethodsTest < Minitest::Test
  #
  # Operators
  #
  def test_the_add_operator
    add1 = Numerics + 1

    assert_equal 4, add1[3]

    assert_equal [3, 4, 5], [1, 2, 3].map(&Numerics + 2)
  end

  def test_the_subtract_operator
    assert_equal [0, 1, 2], [1, 2, 3].map(&Numerics - 1)
  end

  def test_the_divide_operator
    assert_equal [1, 2, 4], [2, 4, 8].map(&Numerics / 2)
  end

  def test_the_multiply_operator
    assert_equal [4, 8, 16], [2, 4, 8].map(&Numerics * 2)
  end

  #
  # Comparables
  #
  def test_the_comparison_with_greater_than
    gt1 = Numerics > 1

    assert_equal true, gt1[3]

    assert_equal [3], [1, 2, 3].select(&Numerics > 2)
  end

  def test_the_comparison_with_greater_than_or_equal
    assert_equal [2, 3], [1, 2, 3].select(&Numerics >= 2)
  end

  def test_the_comparison_with_less_than
    assert_equal [1], [1, 2, 3].select(&Numerics < 2)
  end

  def test_the_comparison_with_less_than_or_equal
    assert_equal [1, 2], [1, 2, 3].select(&Numerics <= 2)
  end
end
