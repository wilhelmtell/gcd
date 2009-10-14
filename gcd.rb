#!/usr/bin/env ruby

require 'options'

if __FILE__ == $0
  options = parse_commandline_options
  a = options.a || gets.to_i
  b = options.b || gets.to_i

  while a > 0
    r = b % a;
    if options.trace
      f = b / a
      puts "#{b}=#{f}*#{a}+#{r}"
    end
    b = a;
    a = r;
  end
  puts b
end
