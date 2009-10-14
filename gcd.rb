#!/usr/bin/env ruby
###############################################################################
# GCD and a little more
#
# ./gcd --help
#
# For the practice session feature you need the HighLine library installed.
#
#  gem install highline
#
# Matan Nassau <matan.nassau@gmail.com>
###############################################################################

require 'options'

# returns [i,j,gcd] s.t. i*n+j*m=1
def extended_euclidean(n,m,opts)
  if m == 0
    return 1,0,n
  end
  if opts.trace
    f = n / m
    puts "#{n}=#{f}*#{m}+#{n%m}"
  end
  i,j,gcd = extended_euclidean(m,n%m,opts)
  i,j,gcd = j, i-((n/m)*j), gcd
  puts "#{gcd}=#{i}*#{n}+#{j}*#{m}" if opts.trace and opts.extended
  return [i,j,gcd]
end

def practice(opts)
  require 'highline/system_extensions'
  include HighLine::SystemExtensions
  srand(Time.now.to_i)
  c = 0
  while c != 'q'.ord
    a, b = 0, 0
    a = rand(10000) while a % 2 == 0
    b = rand(10000) while b % 2 == 0
    puts "q to quit, any other key for the solution and another round."
    puts '+-' + "a=#{a}, b=#{b}".gsub(/./, '-') + '-+'
    puts "| a=#{a}, b=#{b} |"
    puts '+-' + "a=#{a}, b=#{b}".gsub(/./, '-') + '-+'
    break if get_character() == 'q'.ord
    inv,k,gcd = extended_euclidean(a,b,opts)
    if inv < 0 and opts.extended and opts.trace
      puts "#{inv}mod#{b}=#{inv%b}"
    end
    puts "gcd=#{gcd}, #{a}^-1 mod #{b}=#{inv % b}"
  end
end

# main entry
def go_beaver_go()
  options = parse_commandline_options
  if options.practice
    practice(options)
  else
    a = options.a || gets.to_i
    b = options.b || gets.to_i
    inv,k,gcd = extended_euclidean(a,b,options)
    if inv < 0 and options.extended and options.trace
      puts "#{inv}mod#{b}=#{inv%b}"
    end
    print gcd
    print ' ', inv % b if options.extended
    puts
  end
end

if __FILE__ == $0
  go_beaver_go
end
