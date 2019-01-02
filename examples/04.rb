# frozen_string_literal: true

raise 'Wrong Ruby version!' unless RUBY_VERSION >= '2.6.0'

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'ruby-lambdas', require: 'ruby/lambdas'
  gem 'benchmark-ips', '~> 2.7', '>= 2.7.2'
end

############
# Examples #
############

Student = Struct.new(:name, :grade, keyword_init: true)

STUDENTS = [
  { name: 'Rodrigo', grade: 6 },
  { name: 'Talita' , grade: 9 },
  { name: 'Bella'  , grade: 10 },
  { name: 'Lara'   , grade: 10 }
].map &Student.method(:new)

ByName = -> student { student.name }
FetchGrade = -> student { student.grade }
IsApproved = FetchGrade >> (Numerics >= 9)

#
# Declarative approach (using functions instead of blocks)
#
p STUDENTS.select(&IsApproved).map(&ByName)

#
# An Imperative version from the previous example
#
p STUDENTS.select{ |student| student.grade >= 9 }
          .map{ |student| student.name }

##############
# Benchmarks #
##############

require 'benchmark/ips'

IsApproved2 = -> student { student.grade >= 9 }

Benchmark.ips do |x|
  x.report('Imperative') do
    STUDENTS.select { |student| student.grade >= 9 }
  end

  x.report('Declarative (with composition)') do
    STUDENTS.select(&IsApproved)
  end

  x.report('Declarative (without composition)') do
    STUDENTS.select(&IsApproved2)
  end

  x.compare!
end

# ruby -v examples/02.rb
# ruby 2.6.0p0 (2018-12-25 revision 66547) [x86_64-darwin17]
# Warming up --------------------------------------
#           Imperative   155.896k i/100ms
# Declarative (with composition)
#                         58.468k i/100ms
# Declarative (without composition)
#                        153.103k i/100ms
# Calculating -------------------------------------
#           Imperative      2.542M (± 1.3%) i/s -     12.783M in   5.029394s
# Declarative (with composition)
#                         690.140k (± 1.6%) i/s -      3.508M in   5.084486s
# Declarative (without composition)
#                           2.408M (± 1.5%) i/s -     12.095M in   5.024628s

# Comparison:
#           Imperative:  2542164.1 i/s
# Declarative (without composition):  2407753.3 i/s - 1.06x  slower
# Declarative (with composition):   690140.5 i/s - 3.68x  slower
