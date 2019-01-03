require "test_helper"

class RubyLambdasStrictModeTest < Minitest::Test
  def setup
    load("ruby/lambdas/core/strict_mode/enable.rb")
  end

  def teardown
    load("ruby/lambdas/core/strict_mode/disable.rb")
  end

  def test_the_strict_mode_behaviors
    teardown

    assert_equal 1, String!(1)
    assert_equal "1", Numeric!("1")

    setup

    assert_equal 1, Numeric!(1)
    assert_equal "1", String!("1")

    num_err = assert_raises(TypeError) { Numeric!("1") }
    assert_equal "\"1\" must be Numeric", num_err.message

    str_err = assert_raises(TypeError) { String!(1) }
    assert_equal "1 must be a String", str_err.message
  end

  def test_numeric_functions_in_the_strict_mode
    [
      :Add, :Divide, :Subtract, :Multiply,
      :GreaterThan, :GreaterThanOrEqual,
      :LessThan, :LessThanOrEqual
    ].each do |function_name|
      must_be_numeric { Numerics.const_get(function_name).call("1", "2") }
    end
  end

  def test_string_functions_in_the_strict_mode
    [
      :Capitalize, :Downcase, :Strip
    ].each do |function_name|
      must_be_a_string { Strings.const_get(function_name).call(1) }
    end

    must_be_a_string { Strings::Center[1, 1] }
    must_be_a_string { Strings::CenterWith[1, '-', 1] }
    must_be_a_string { Strings::GSub[' ', '-', 1] }
  end

  private

  def must_be_numeric(&block)
    err = assert_raises(TypeError, &block)
    assert_match(/must be Numeric/, err.message)
  end

  def must_be_a_string(&block)
    err = assert_raises(TypeError, &block)
    assert_match(/must be a String/, err.message)
  end
end
