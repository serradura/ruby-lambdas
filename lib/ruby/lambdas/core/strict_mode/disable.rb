[:String!, :Numeric!].each do |name|
  Kernel.remove_method(name) if Kernel.respond_to?(name)
end

module Kernel
  def String!(data)
    data
  end

  def Numeric!(data)
    data
  end
end
