require "fileutils"
require "optparse"

# Import all utils
Dir["/usr/local/Casa/lib/utils/*.rb"].each { |file| require file }


##########################
#### Command: furnish ####
##########################

### Docs ###
#
# This is the main "set up your dev environment using these configs" command.
# It must be run in a directory with a casa.yml file.

### Options ###
class Parser
  @options_struct = Struct.new :name

  def self.parse options
    args = @options_struct.new "furnish"

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: casa furnish"
      opts.separator  ""
      opts.separator  "Options"

      opts.on "-h", "--help", "Prints furnish command help" do
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

module Furnish
  def self.run args=[]
    ## Check to make sure in a directory with a casa_config.yml file 
    if !File.exist? "casa.yml"
      abort "You need to be in a directory with a casa.yml file!"
    end

    ## Load YAML & set related variables
    yaml = YamlHelper.load_yaml_to_object "casa.yml"
    packages_obj = {
      "brew_kegs" => yaml["brew_kegs"] || [],
      "ruby_gems" => yaml["ruby_gems"] || [],
      "pip_packages" => yaml["pip_packages"] || [],
      "node_modules" => yaml["node_modules"] || [],
      "casa_modules" => yaml["casa_modules"] || []
    }

    scripts_arr = yaml["scripts"] || []

    ## Install all packages
    PackageInstaller.install_all_packages packages_obj

    # ## Run casa module scripts
    ScriptsRunner.run_scripts yaml["scripts"] || []
  end
end