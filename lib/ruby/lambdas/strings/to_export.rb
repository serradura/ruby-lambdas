module RubyLambdas
  module Strings
    module ToExport
      Capitalize = -> data { data.capitalize }

      Center = -> (width, data) { data.center(width) }

      CenterWith = -> (width, padstr, data) { data.center(width, padstr) }

      Downcase = -> data { data.downcase }

      GSub = -> (pattern, replacement, data) do
        return data.gsub(pattern, &replacement) if replacement.is_a?(::Proc)

        data.gsub(pattern, replacement)
      end

      Strip = -> data { data.strip }
    end

    ALIASES = {
      GSub: :ReplaceAll,
      Downcase: :LowerCase,
      Strip: :Trim,
    }.freeze
  end
end
