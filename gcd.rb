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

require_relative 'options'

ERR_INTERRUPT = 1

# returns [i,j,gcd] s.t. i*n+j*m=1
#
# TODO: check if stdout is a tty and output accordingly
def extended_euclidean(n,m,opts)
  if m == 0
    if opts.extended and opts.trace
      a,b = opts.a, opts.b
      puts "gcd(#{a},#{b}) is #{n}"
      if n != 1
        puts "#{a}^-1 mod #{b} doesn't exist since #{a} and #{b} aren't coprimes."
      end
      puts
    end
    return 1,0,n
  end
  puts "#{n}=#{n/m}*#{m}+#{n%m}" if opts.trace and n%m != 0
  i,j,gcd = extended_euclidean(m, n%m, opts)
  if gcd == 1
    i,j = j, i-((n/m)*j)
    if opts.trace and opts.extended and n%m != 0
      puts "#{gcd}=#{i}*#{n}#{j<0 ? '' : '+'}#{j}*#{m}"
    end
  end
  return [i,j,gcd]
end

def practice(opts)
  require 'highline/system_extensions'
  include HighLine::SystemExtensions
  srand(Time.now.to_i)
  c = 0
  while c != 'q'.ord
    a, b = 0, 0
    al,au = opts.arange.first, opts.arange.last
    bl,bu = opts.brange.first, opts.brange.last
    opts.a = a = rand(au) % (au - al + 1) + al while a % 2 == 0
    opts.b = b = rand(bu) % (bu - bl + 1) + bl while b % 2 == 0
    puts "q to quit, any other key for the solution and another round."
    puts '+-' + "a=#{a}, b=#{b}".gsub(/./, '-') + '-+'
    puts "| a=#{a}, b=#{b} |"
    puts '+-' + "a=#{a}, b=#{b}".gsub(/./, '-') + '-+'
    begin
      break if get_character() == 'q'.ord
    rescue Interrupt
      exit ERR_INTERRUPT
    end
    inv,k,gcd = extended_euclidean(a,b,opts)
    if inv < 0 and opts.extended and opts.trace
      puts "#{inv}mod#{b}=#{inv%b}"
    end
    print "gcd=#{gcd}"
    if opts.extended
      print ", #{a}^-1 mod #{b}=#{inv % b}"
      print "\nCheck:  #{a} * #{inv % b} mod #{b} = #{a*(inv%b)} mod #{b} = #{a * (inv%b) % b}"
    end
    puts
  end
end

# main entry
def go_beaver_go()
  options = parse_commandline_options
  if options.practice
    practice(options)
  else
    begin
      a = options.a || gets.to_i
      b = options.b || gets.to_i
    rescue Interrupt
      exit ERR_INTERRUPT
    end
    inv,k,gcd = extended_euclidean(a,b,options)
    if inv < 0 and options.extended and options.trace
      puts "#{inv}mod#{b}=#{inv%b}"
    end
    print gcd
    print ' ', inv % b if options.extended and gcd == 1
    puts
  end
end
