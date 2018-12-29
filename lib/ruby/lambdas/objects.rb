module Objects
  require_relative "import"
  require_relative "objects/to_export"

  RubyLambdas::Import.(from: RubyLambdas::Objects, to: self)
end
