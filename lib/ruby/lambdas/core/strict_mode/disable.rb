#
# These Kernel methods can be overridden by
# new ones if the strict mode was enabled. e.g:
#
#    require "ruby/lambdas/strict-mode"
#
[:String!, :Numeric!].each do |name|
  Kernel.remove_method(name) if Kernel.respond_to?(name)

  Kernel.module_eval { define_method(name) { |data| data } }
end
