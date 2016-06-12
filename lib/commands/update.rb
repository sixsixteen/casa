require "fileutils"
require "optparse"

##########################
#### Command: update #####
##########################

### Docs ###
#
# The update command checks the version of casa and reinstalls if needed.
# Can pass in arguments to update modules to latest version.
#
# THIS IS NOT IMPLEMENTED.
#

### Options ###
class Parser
  @options_struct = Struct.new :name

  def self.parse options
    args = @options_struct.new "update"

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: casa update [-m MODULES]"
      opts.separator  ""
      opts.separator  "Options"

      opts.on "-m", "--modules", "Flag used to indicate if updating modules vs. Casa core" do
        # map modules to @options_struct
      end

      opts.on "-h", "--help", "Prints init command help" do
        puts opts
      end
    end

    opt_parser.parse! options
    # REVIEW: I don't like it, but implicit returns are
    # encouraged in ruby
    args
  end
end

##########################
##########################
##########################

module Command
  module Update
    def self.run _args=[]
      puts "Updating casa..."
    end
  end
end
