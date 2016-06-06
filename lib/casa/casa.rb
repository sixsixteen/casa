#!/usr/bin/env ruby

# Import all casa commands
Dir["/usr/local/Casa/lib/commands/*.rb"].each { |file| require file }

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

module Casa
  def self.run command
    unless command.nil?
      cap_command = command.capitalize
      if Object.const_defined? cap_command
        # Imported command modules are capitalized versions of script commands. Pass along args/options from command line minus "casa"
        command_module = Object.const_get command.capitalize
        command_module.run ARGV.drop 1
        return
      else
        puts "The command #{command} was not found."
      end
    end

    puts "Run $ casa help or $ casa COMMAND --help to see documentation."
  end
end

Casa.run ARGV[0]