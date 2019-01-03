module RubyLambdas
  module Strings
    module ToExport
      Capitalize = -> data { String!(data).capitalize }

      Center = -> (width, data) { String!(data).center(width) }

      CenterWith = -> (width, padstr, data) do
        String!(data).center(width, padstr)
      end

      Downcase = -> data { String!(data).downcase }

      FromObject = -> data { String(data) }

      GSub = -> (pattern, repl, data) do
        return String!(data).gsub(pattern, &repl) if repl.is_a?(::Proc)

        String!(data).gsub(pattern, repl)
      end

      Strip = -> data { String!(data).strip }
    end

    ALIASES = {
      Downcase: :LowerCase,
      FromObject: :String,
      GSub: :ReplaceAll,
      Strip: :Trim,
    }.freeze
  end
end
