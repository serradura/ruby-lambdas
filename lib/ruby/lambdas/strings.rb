module Strings
  require_relative "core/strict_mode/disable"
  require_relative "core/import"
  require_relative "strings/to_export"
  require_relative "strings/type_error"

  RubyLambdas::Import.(from: RubyLambdas::Strings, to: self)
end
