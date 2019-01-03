module Strings
  require_relative "core/import"
  require_relative "strings/to_export"

  RubyLambdas::Import.(from: RubyLambdas::Strings, to: self)
end
