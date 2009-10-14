#!/usr/bin/env ruby

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

# main entry
def go_beaver_go()
  options = parse_commandline_options
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

if __FILE__ == $0
  go_beaver_go
end
