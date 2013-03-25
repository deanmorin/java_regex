class JavaRegexException
  # Exception raised when a Java Regex feature is not supported by Ruby, or
  # when this gem doesn't support it
  class TranslationError < StandardError; end
end
