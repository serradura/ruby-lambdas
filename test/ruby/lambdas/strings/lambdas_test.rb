require "test_helper"

module Strings
  class LambdasTest < Minitest::Test
    #
    # String#capitalize
    #
    def test_the_capitalize_function_output
      assert_equal "Foo", Capitalize.call("foo")
      assert_equal "Foo", Capitalize.call("foO")
      assert_equal "Foo", Capitalize.call("fOO")
      assert_equal "Foo", Capitalize.call("FOO")
    end

    #
    # String#center
    #
    def test_the_center_function_output
      assert_equal "ahoy", Center.call(4, "ahoy")
      assert_equal "       hello        ", Center.call(20, "hello")

      center_with_four = Center.call(4)

      assert_equal "ahoy", center_with_four.call("ahoy")
      assert_equal " go ", center_with_four.call("go")
    end

    def test_the_center_with_function_output
      assert_equal "1231231hello12312312", CenterWith.call(20, "123", "hello")

      center_if_twenty = CenterWith.call(20)

      assert_equal "1231231hello12312312", center_if_twenty.call( "123", "hello")

      center_if_twenty_with_123 = CenterWith.call(20, "123")

      assert_equal "1231231hello12312312", center_if_twenty_with_123.call("hello")
    end

    #
    # String#downcase
    #
    def test_the_downcase_function_output
      assert_equal "foo", Downcase.call("Foo")
      assert_equal "foo", Downcase.call("FOo")
      assert_equal "foo", Downcase.call("FOO")

      assert_same Downcase, LowerCase
    end

    #
    # Kernel.String
    #
    def test_the_from_function_output
      assert_equal "", FromObject.call(nil)
      assert_equal "1", FromObject.call(1)
      assert_equal "1.0", FromObject.call(1.0)

      assert_same FromObject, String
    end

    #
    # String#gsub
    #
    def test_the_gsub_function_output
      assert_equal "h*ll*", GSub.call(/[aeiou]/, "*", "hello")

      # ---

      wrap_vowels = GSub.call(/([aeiou])/, '<\1>')

      assert_equal "h<e>ll<o>", wrap_vowels.call("hello")

      # ---

      replace_vowels = GSub.call(/[aeiou]/)

      hide_vowels = replace_vowels.call("*")

      assert_equal "h*ll*", hide_vowels.call("hello")

      # ---

      ordinal_number = -> s { s.ord.to_s + ' '}

      assert_equal "104 101 108 108 111 ", GSub.call(/./, ordinal_number, "hello")

      replace_chars_by_its_ordinal_numbers = GSub.call(/./, ordinal_number)

      assert_equal "104 101 108 108 111 ", replace_chars_by_its_ordinal_numbers.call("hello")

      # ---

      assert_equal "h{e}ll{o}", GSub.call(/(?<foo>[aeiou])/, '{\k<foo>}', "hello")

      # ---

      assert_equal "h3ll*", GSub.call(/[eo]/, {'e' => 3, 'o' => '*'}, "hello")

      # ---

      assert_same GSub, ReplaceAll
    end

    #
    # String#strip
    #
    def test_the_strip_function_output
      assert_equal "hello", Strip.call("    hello    ")
      assert_equal "goodbye", Strip.call("\tgoodbye\r\n")
      assert_equal "", Strip.call("\x00\t\n\v\f\r ")

      assert_same Strip, Trim
    end
  end
end
