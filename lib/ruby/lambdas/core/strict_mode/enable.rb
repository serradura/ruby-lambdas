[:String!, :Numeric!].each do |name|
  Kernel.remove_method(name) if Kernel.respond_to?(name)
end

module Kernel
  def String!(data)
    return data if data.is_a?(::String)

    raise Strings::TypeError.new(data)
  end

  def Numeric!(data)
    return data if data.is_a?(::Numeric)

    raise Numerics::TypeError.new(data)
  end
end
