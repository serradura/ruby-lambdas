require "test_helper"

class RubyLambdasNumericsLambdasTest < Minitest::Test
  #############
  # Operators #
  #############

  #
  # Numeric#+
  #
  def test_the_add_function_output
    assert_equal 2, Numerics::Add.call(1, 1)

    add1 = Numerics::Add.call(1)

    assert_equal 4, add1[3]
  end

  #
  # Numeric#/
  #
  def test_the_divide_functions
    assert_equal 2, Numerics::Divide.call(4, 2)

    divide_6_by = Numerics::Divide.call(6)

    assert_equal 2, divide_6_by[3]
  end

  #
  # Numeric#-
  #
  def test_the_subtract_functions
    assert_equal 1, Numerics::Subtract.call(2, 1)

    sub1 = Numerics::Subtract.call(1)

    assert_equal(-2, sub1[3])
  end

  #
  # Numeric#*
  #
  def test_the_multiply_function_output
    assert_equal 1, Numerics::Multiply.call(1, 1)

    multiple_by_2 = Numerics::Multiply.call(2)

    assert_equal 6, multiple_by_2[3]
  end

  ###############
  # Comparables #
  ###############

  #
  # Numeric#>
  #
  def test_the_greater_than_function
    assert_equal true, Numerics::GreaterThan.call(2, 1)

    gt1 = Numerics::GreaterThan.call(1)

    assert_equal true, gt1[0]

    assert_same Numerics::GreaterThan, Numerics::Gt
  end

  #
  # Numeric#>=
  #
  def test_the_greater_than_or_equal_function
    assert_equal true, Numerics::GreaterThanOrEqual.call(2, 2)

    gt1 = Numerics::GreaterThanOrEqual.call(1)

    assert_equal true, gt1[1]

    assert_same Numerics::GreaterThanOrEqual, Numerics::Gte
  end

  #
  # Numeric#<
  #
  def test_the_less_than_function
    assert_equal false, Numerics::LessThan.call(2, 2)

    lt1 = Numerics::LessThan.call(1)

    assert_equal false, lt1[1]

    assert_same Numerics::LessThan, Numerics::Lt
  end

  #
  # Numeric#<=
  #
  def test_the_less_than_or_equal_function
    assert_equal true, Numerics::LessThanOrEqual.call(2, 2)

    lte1 = Numerics::LessThanOrEqual.call(1)

    assert_equal true, lte1[1]

    assert_same Numerics::LessThanOrEqual, Numerics::Lte
  end
end
