module RubyLambdas
  module Objects
    module ToExport
      ToS = -> data { data.to_s }
    end

    ALIASES = {
      ToS: :ToString
    }.freeze
  end
end
