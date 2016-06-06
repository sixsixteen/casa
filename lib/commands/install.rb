require "fileutils"
require "optparse"

# Import all utils
Dir["/usr/local/Casa/lib/utils/*.rb"].each { |file| require file }

##########################
#### Command: install ####
##########################

### Docs ###
#
# The install command takes a list of modules to install from the Casa registry.
# 
# THIS IS NOT IMPLEMENTED. It currently iterates through the Palacio directory (where globally)
# installed modules will be stored and reports on the module's existence.
#

### Options ###
class Parser
  @options_struct = Struct.new :name

  def self.parse options
    args = @options_struct.new "install"

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: casa install mongodb twitter-onboard"
      opts.separator  ""
      opts.separator  "Options"

      opts.on "-h", "--help", "Prints install command help" do
        puts opts
      end
    end

    opt_parser.parse! options
    return args
  end
end

##########################
##########################
##########################

module Install
  def self.run args=[]
    args.each { |i| 
      if Dir.exist? "/usr/local/Palacio/modules/#{i}"
        puts "The module #{i} exist!"
      else
        puts "#{i} is not a module!"
      end
    }
  end
end
