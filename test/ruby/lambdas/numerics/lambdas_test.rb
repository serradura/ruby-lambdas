require "test_helper"

module Numerics
  class LambdasTest < Minitest::Test
    #############
    # Operators #
    #############

    #
    # Numeric#+
    #
    def test_the_add_function_output
      assert_equal 2, Add.call(1, 1)

      add1 = Add.call(1)

      assert_equal 4, add1[3]
    end

    #
    # Numeric#/
    #
    def test_the_divide_functions
      assert_equal 2, Divide.call(2, 4)

      divide_by_3 = Divide.call(3)

      assert_equal 2, divide_by_3[6]
    end

    #
    # Numeric#-
    #
    def test_the_subtract_functions
      assert_equal 1, Subtract.call(1, 2)

      subtract_3_from = Subtract.call(3)

      assert_equal(-2, subtract_3_from[1])
    end

    #
    # Numeric#*
    #
    def test_the_multiply_function_output
      assert_equal 1, Multiply.call(1, 1)

      multiple_by_2 = Multiply.call(2)

      assert_equal 6, multiple_by_2[3]
    end

    ###############
    # Comparables #
    ###############

    #
    # Numeric#>
    #
    def test_the_greater_than_function
      assert_equal true, GreaterThan.call(1, 2)

      gt1 = GreaterThan.call(1)

      assert_equal false, gt1[0]

      assert_same GreaterThan, Gt
    end

    #
    # Numeric#>=
    #
    def test_the_greater_than_or_equal_function
      assert_equal true, GreaterThanOrEqual.call(2, 2)

      gt1 = GreaterThanOrEqual.call(1)

      assert_equal true, gt1[1]

      assert_same GreaterThanOrEqual, Gte
    end

    #
    # Numeric#<
    #
    def test_the_less_than_function
      assert_equal false, LessThan.call(2, 2)

      lt1 = LessThan.call(1)

      assert_equal false, lt1[1]

      assert_same LessThan, Lt
    end

    #
    # Numeric#<=
    #
    def test_the_less_than_or_equal_function
      assert_equal true, LessThanOrEqual.call(2, 2)

      lte1 = LessThanOrEqual.call(1)

      assert_equal true, lte1[1]

      assert_same LessThanOrEqual, Lte
    end
  end
end
