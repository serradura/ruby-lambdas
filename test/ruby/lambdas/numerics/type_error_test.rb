require "test_helper"

module Numerics
  class TypeErrorTest < Minitest::Test
    def test_that_numerics_type_error_is_a_type_error
      assert TypeError < ::TypeError
    end
  end
end
