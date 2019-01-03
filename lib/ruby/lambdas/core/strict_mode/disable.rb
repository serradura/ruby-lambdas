#
# These Kernel methods can be overridden by
# new ones if the strict mode was enabled. e.g:
#
#    require "ruby/lambdas/strict-mode"
#
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
