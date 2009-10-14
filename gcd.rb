#!/usr/bin/env ruby

require 'optparse'
require 'ostruct'

def parse_commandline_options()
  options = OpenStruct.new
  options.trace = false
  OptionParser.new do |opts|
    opts.banner = "Usage:  #{$0} [options]"
    opts.on("-t", "--trace", "Trace out the solution") do |v|
      options.trace = v
    end
    opts.on("-a", "--a INTEGER", Integer, "Set value for a") do |v|
      options.a = v
    end
    opts.on("-b", "--b INTEGER", Integer, "Set value for b") do |v|
      options.b = v
    end
  end.parse!
  return options
end

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
