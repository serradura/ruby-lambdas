require "test_helper"

class RubyLambdasObjectsTest < Minitest::Test
  #
  # Object#to_s
  #
  def test_the_to_s_function_output
    assert_equal "", Objects::ToS.call(nil)
    assert_equal "1", Objects::ToS.call(1)
    assert_equal "1.0", Objects::ToS.call(1.0)

    assert_same Objects::ToS, Objects::ToString
  end
end
