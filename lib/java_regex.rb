# encoding=utf-8
class JavaRegex
  attr_accessor :regex

  def initialize(regex)
    @regex = regex
  end

  def to_ruby
    Translator.translate(@regex)
  end

  def to_ruby_regex
    Regexp.new(to_ruby())
  end
end

require 'java_regex/exceptions'
require 'java_regex/translator'
