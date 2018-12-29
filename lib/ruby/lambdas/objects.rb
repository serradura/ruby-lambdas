module Objects
  require_relative "objects/to_export"

  RubyLambdas::Objects::ToExport.tap do |to_export|
    to_export
      .constants
      .each do |function_name|
        function = to_export.const_get(function_name)

        const_set(
          function_name,
          function.arity == 1 ? function : function.curry
        )
      end
  end

  RubyLambdas::Objects::ALIASES
    .each do |name, new_names|
      Array(new_names).each { |new_name| const_set(new_name, const_get(name)) }
    end
end
