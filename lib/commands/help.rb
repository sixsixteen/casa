##########################
#### Command: help #######
##########################

### Docs ###
#
# Prints list of commands for casa.
#
# TODO: print short description of each command
#

module Command
  module Help
    def self.run args=[]
      print <<-SOS
      Casa
        Usage: casa COMMAND [SPECIFIER] [OPTIONS]

        Commands
          help: casa help
          update: casa update

          init: casa init TYPE
          furnish: casa furnish
      SOS
    end
  end
end
