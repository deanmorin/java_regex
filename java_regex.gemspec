Gem::Specification.new do |s|
  s.name        = 'java_regex'
  s.version     = '0.0.2'
  s.date        = '2013-04-01'
  s.summary     = 'Converts Java regexes to Ruby regexes'
  s.description = <<-eos
    For the most common cases, either converts to the Ruby equivalent, or
    throws an exception if conversion is not supported.
  eos
  s.authors     = ['Dean Morin']
  s.email       = 'morin.dean@gmail.com'
  s.homepage    = 'http://github.com/deanmorin/java_regex'
  s.license     = 'MIT'
  s.files       = ['lib/java_regex.rb',
                   'lib/java_regex/translator.rb',
                   'lib/java_regex/exceptions.rb']
end
