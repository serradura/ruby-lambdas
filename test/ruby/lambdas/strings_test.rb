require "test_helper"

class RubyLambdasStringsTest < Minitest::Test
  #
  # String#capitalize
  #
  def test_the_capitalize_function_output
    assert_equal "Foo", Strings::Capitalize.call("foo")
    assert_equal "Foo", Strings::Capitalize.call("foO")
    assert_equal "Foo", Strings::Capitalize.call("fOO")
    assert_equal "Foo", Strings::Capitalize.call("FOO")
  end

  #
  # String#center
  #
  def test_the_center_function_output
    assert_equal "ahoy", Strings::Center.call(4, "ahoy")
    assert_equal "       hello        ", Strings::Center.call(20, "hello")

    center_with_four = Strings::Center.call(4)

    assert_equal "ahoy", center_with_four.call("ahoy")
    assert_equal " go ", center_with_four.call("go")
  end

  def test_the_center_with_function_output
    assert_equal "1231231hello12312312", Strings::CenterWith.call(20, "123", "hello")

    center_if_twenty = Strings::CenterWith.call(20)

    assert_equal "1231231hello12312312", center_if_twenty.call( "123", "hello")

    center_if_twenty_with_123 = Strings::CenterWith.call(20, "123")

    assert_equal "1231231hello12312312", center_if_twenty_with_123.call("hello")
  end

  #
  # String#downcase
  #
  def test_the_downcase_function_output
    assert_equal "foo", Strings::Downcase.call("Foo")
    assert_equal "foo", Strings::Downcase.call("FOo")
    assert_equal "foo", Strings::Downcase.call("FOO")

    assert_same Strings::Downcase, Strings::LowerCase
  end

  #
  # String#gsub
  #
  def test_the_gsub_function_output
    assert_equal "h*ll*", Strings::GSub.call(/[aeiou]/, "*", "hello")

    # ---

    wrap_vowels = Strings::GSub.call(/([aeiou])/, '<\1>')

    assert_equal "h<e>ll<o>", wrap_vowels.call("hello")

    # ---

    replace_vowels = Strings::GSub.call(/[aeiou]/)

    hide_vowels = replace_vowels.call("*")

    assert_equal "h*ll*", hide_vowels.call("hello")

    # ---

    ordinal_number = -> s { s.ord.to_s + ' '}

    assert_equal "104 101 108 108 111 ", Strings::GSub.call(/./, ordinal_number, "hello")

    replace_chars_by_its_ordinal_numbers = Strings::GSub.call(/./, ordinal_number)

    assert_equal "104 101 108 108 111 ", replace_chars_by_its_ordinal_numbers.call("hello")

    # ---

    assert_equal "h{e}ll{o}", Strings::GSub.call(/(?<foo>[aeiou])/, '{\k<foo>}', "hello")

    # ---

    assert_equal "h3ll*", Strings::GSub.call(/[eo]/, {'e' => 3, 'o' => '*'}, "hello")

    # ---

    assert_same Strings::GSub, Strings::ReplaceAll
  end

  #
  # String#strip
  #
  def test_the_strip_function_output
    assert_equal "hello", Strings::Strip.call("    hello    ")
    assert_equal "goodbye", Strings::Strip.call("\tgoodbye\r\n")
    assert_equal "", Strings::Strip.call("\x00\t\n\v\f\r ")

    assert_same Strings::Strip, Strings::Trim
  end
end
