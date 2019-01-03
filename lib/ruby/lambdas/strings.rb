module Strings
  require_relative "core/strict_mode/disable"
  require_relative "core/import"
  require_relative "strings/to_export"

  RubyLambdas::Import.(from: RubyLambdas::Strings, to: self)
end
