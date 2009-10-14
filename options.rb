require 'optparse'
require 'ostruct'

def parse_commandline_options()
  options = OpenStruct.new
  options.trace = false
  options.extended = false
  options.practice = false
  OptionParser.new do |opts|
    opts.banner = "Usage:  #{$0} [options]"
    opts.on("-t", "--trace", "Trace out the solution") do |v|
      options.trace = v
    end
    opts.on("-e", "--extended", "Find a^-1 mod b") do |v|
      options.extended = v
    end
    opts.on("-p", "--practice", "Enter a practice session") do |v|
      options.practice = v
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

