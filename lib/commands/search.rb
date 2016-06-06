require "optparse"

# Import all utils
Dir["/usr/local/Casa/lib/utils/*.rb"].each { |file| require file }

##########################
#### Command: search #####
##########################

### Docs ###
#
# Searches the casa registry.
# 
# THIS IS NOT IMPLEMENTED.
#

### Options ###
class Parser
  @options_struct = Struct.new :name

  def self.parse(options)
    args = @options_struct.new "search"

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: casa search"
      opts.separator  ""
      opts.separator  "Options"

      opts.on "-h", "--help", "Prints search command help" do
        puts opts
      end
    end

    opt_parser.parse! options
    return args
  end
end

##########################
##########################

module Search
	def self.run args=[]
		puts "Searching!"
	end
end
