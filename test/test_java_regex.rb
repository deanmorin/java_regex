# encoding=utf-8
require 'test/unit'
require 'java_regex'

class JavaRegexTest < Test::Unit::TestCase
  def test_characters
    assert_raise JavaRegexException::TranslationError do
      JavaRegex.new('\Q').to_ruby()
    end
    assert_raise JavaRegexException::TranslationError do
      JavaRegex.new('\E').to_ruby()
    end
    assert_raise JavaRegexException::TranslationError do
      JavaRegex.new('\cA').to_ruby()
    end
    assert_raise JavaRegexException::TranslationError do
      JavaRegex.new('\cZ').to_ruby()
    end
  end

  def test_character_classes_or_character_sets
    assert_raise JavaRegexException::TranslationError do
      JavaRegex.new('[\d-z]').to_ruby()
    end
    assert_equal '\A[a-z]\z', JavaRegex.new('[a-z]').to_ruby()
  end

  def test_word_boundaries
    assert_raise JavaRegexException::TranslationError do
      JavaRegex.new('\bア').to_ruby()
    end
    assert_raise JavaRegexException::TranslationError do
      JavaRegex.new('\Bア').to_ruby()
    end
  end

  def test_modifiers
    assert_raise JavaRegexException::TranslationError do
      JavaRegex.new('abc\nabc').to_ruby()
    end
  end

  def test_unicode_characters
    assert_equal '\Aア\z', JavaRegex.new('\u30A2').to_ruby()
    assert_equal '\Apreア¥post\z',
      JavaRegex.new('pre\u30A2\u00a5post').to_ruby()
  end

  def test_posix_bracket_expressions
    assert_equal '\A[[:lower:]]\z', JavaRegex.new('\p{Lower}').to_ruby()
    assert_equal '\A[[:upper:]]\z', JavaRegex.new('\p{Upper}').to_ruby()
    assert_equal '\A[[:alpha:]]\z', JavaRegex.new('\p{Alpha}').to_ruby()
    assert_equal '\A[[:digit:]]\z', JavaRegex.new('\p{Digit}').to_ruby()
    assert_equal '\A[[:alnum:]]\z', JavaRegex.new('\p{Alnum}').to_ruby()
    assert_equal '\A[[:punct:]]\z', JavaRegex.new('\p{Punct}').to_ruby()
    assert_equal '\A[[:graph:]]\z', JavaRegex.new('\p{Graph}').to_ruby()
    assert_equal '\A[[:print:]]\z', JavaRegex.new('\p{Print}').to_ruby()
    assert_equal '\A[[:blank:]]\z', JavaRegex.new('\p{Blank}').to_ruby()
    assert_equal '\A[[:cntrl:]]\z', JavaRegex.new('\p{Cntrl}').to_ruby()
    assert_equal '\A[[:space:]]\z', JavaRegex.new('\p{Space}').to_ruby()
    assert_equal '\A[[:xdigit:]]\z', JavaRegex.new('\p{XDigit}').to_ruby()
    assert_equal '\A[[:print:][:cntrl:]]\z',
      JavaRegex.new('\p{ASCII}').to_ruby()

    re = JavaRegex.new('a\p{Digit}c').to_ruby_regex()
    assert_not_nil 'a3c'.match(re)
    assert_nil 'abc'.match(re)
  end

  def test_to_ruby
    # calling to_ruby should always return the same result
    jre = JavaRegex.new('abc')
    assert_equal '\Aabc\z', jre.to_ruby()
    assert_equal '\Aabc\z', jre.to_ruby()
  end
end
