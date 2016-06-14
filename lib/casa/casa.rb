#!/usr/bin/env ruby

# Import all casa commands + utils
# REVIEW: /usr/local shouldn't be hardcoded in, it should
# either be a constant, or, even better: the program should
# not be reliant on being installed in a specific location.
Dir["#{__dir__}/../utils/*.rb"].each { |file| require file }
Dir["#{__dir__}/../commands/*.rb"].each { |file| require file }

##########################
########## casa ##########
##########################

### Docs ###
#
# The Casa CLI command ($ casa )
#

##########################
##########################
##########################

# REVIEW: creating a module with a single method, and no
# constants, submodules, etc., and then calling that single
# method seems like OOP for OOP's sake.
module Casa
  def self.run command
    unless command.nil?
      cap_command = command.capitalize
      # REVIEW: the const_defined stuff is still weird but I
      # can't think of a great solution
      if Command.const_defined? cap_command
        # Imported command modules are capitalized versions
        # of script commands. Pass along args/options from
        # command line minus "casa"
        command_module = Command.const_get cap_command
        command_module.run ARGV.drop 1
        return
      else
        puts "The command #{command} was not found."
      end
    end

    puts "Run $ casa help or $ casa COMMAND --help to see documentation."
  end
end

# REVIEW: whatever editor you're using, it should insert
# newlines at the end of files automatically
Casa.run ARGV[0]
