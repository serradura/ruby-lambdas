module RubyLambdas
  class Import
    def self.call(from:, to:)
      to_export = from::ToExport

      to_export.constants.each do |function_name|
        function = to_export.const_get(function_name)

        to.const_set(
          function_name,
          function.arity == 1 ? function : function.curry
        )
      end

      return unless from.const_defined?(:ALIASES)

      from::ALIASES.each do |name, new_names|
        Array(new_names)
          .each { |new_name| to.const_set(new_name, to.const_get(name)) }
      end
    end
  end
end
