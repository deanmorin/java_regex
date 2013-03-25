# encoding=utf-8
class JavaRegex::Translator
  def self.translate(regex)
    characters(regex)
    character_classes_or_character_sets(regex)
    word_boundaries(regex)
    modifiers(regex)
    unicode_characters!(regex)
    posix_bracket_expressions!(regex)
    regex.sub!(/\A(.*)\z/, '/\A\1\z/')
    return regex
  end

  def self.characters(regex)
    meta_char_start = regex.scan('\Q')  
    meta_char_end = regex.scan('\E')  
    control_char = regex.scan(/\\c[[:upper:]]/)
    raise JavaRegexException::TranslationError,
      '"\Q" and "\E" are not supported' unless
        meta_char_start.empty? and 
        meta_char_end.empty?
    raise JavaRegexException::TranslationError,
      '"\cA" through "\cZ" are not supported' unless
        control_char.empty?
  end

  def self.character_classes_or_character_sets(regex)
    literal_hyphen = regex.scan(/\[\\.-.\]/)
    raise JavaRegexException::TranslationError,
      'Literal hyphens like [\d-z] are not supported' unless
        literal_hyphen.empty?
  end

  def self.word_boundaries(regex)
    non_ascii = regex.scan(/\\[bB][[:print:][:cntrl:]]/)
    raise JavaRegexException::TranslationError,
      'Non-ascii characters following "\b" or "\B" are not supported' unless
        non_ascii.empty?
  end

  def self.modifiers(regex)
    newline = regex.scan(/\\n/)
    raise JavaRegexException::TranslationError,
      'Newlines are currently not supported' unless
        newline.empty?
  end

  def self.unicode_characters!(regex)
    re = /\\u([[:xdigit:]]{4})/
    regex.gsub!(re) { |m| m.gsub!(/\A.*\z/, [Integer("0x#{$1}")].pack('U*')) }
  end

  def self.posix_bracket_expressions!(regex)
    regex.gsub!('\p{Lower}', '[[:lower:]]')
    regex.gsub!('\p{Upper}', '[[:upper:]]')
    regex.gsub!('\p{Alpha}', '[[:alpha:]]')
    regex.gsub!('\p{Digit}', '[[:digit:]]')
    regex.gsub!('\p{Alnum}', '[[:alnum:]]')
    regex.gsub!('\p{Punct}', '[[:punct:]]')
    regex.gsub!('\p{Graph}', '[[:graph:]]')
    regex.gsub!('\p{Print}', '[[:print:]]')
    regex.gsub!('\p{Blank}', '[[:blank:]]')
    regex.gsub!('\p{Cntrl}', '[[:cntrl:]]')
    regex.gsub!('\p{Space}', '[[:space:]]')
    regex.gsub!('\p{XDigit}', '[[:xdigit:]]')
    regex.gsub!('\p{ASCII}', '[[:print:][:cntrl:]]')
  end
end
