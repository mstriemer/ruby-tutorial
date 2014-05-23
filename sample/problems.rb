def fib(n)
    if n > 1
        fib(n - 1) + fib(n - 2)
    else
        n
    end
end

def hey now
    puts(now)
end


# irb
#
# 1. irb
#
# Functions
#
# 1. definition (parens)
# 2. invocation (parens)
#
# Classes
#
# 1. definition
# 2. inheritance
# 3. include, extend?
#
# Using blocks ...
# Loops
#
# 1. each (range?)
# 2. times
# 3. upto
#
# Functional
# 1. map
# 2. select
#
# Writing blocks ...
#
# 1. conditional
# 2. exceptions (explain these?)
# 3. callbacks - async
#
# Metaprogramming
#
# 1. define_method
# 2. send
# 3. method_missing
# 4. code in class definition
# 5. "macros"
# 6. DSLs

10.times do |i|
    puts fib(i)
end

(2..10).each { |i| puts fib i }

(2..10).select { |i| i % 2 == 0 }.each { |i| puts i }

def all_fib
  a, b = 0, 1
  while true do
    puts a
    a, b = b, a + b
    break if a > 1000
  end
end

# Objects
