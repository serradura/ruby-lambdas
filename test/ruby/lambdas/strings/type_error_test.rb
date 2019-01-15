require "test_helper"

module Strings
  class TypeErrorTest < Minitest::Test
    def test_that_strings_type_error_is_a_type_error
      assert TypeError < ::TypeError
    end
  end
end
