$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

class SqlState < StandardError
  # The version of the sqlstate gem.
  VERSION = '0.0.1'
end

require 'sqlstate/standard'

