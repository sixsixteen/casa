require "fileutils"
require "optparse"

# Import all utils

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
    args
  end
end

##########################
##########################
##########################

module Command
  SOURCES = %w(brew_kegs ruby_gems pip_packages node_modules casa_modules)
  module Furnish
    def self.run _args=[]
      unless File.exist? "casa.yml"
        abort "You need to be in a directory with a casa.yml file!"
      end

      ## Load YAML & set related variables
      yaml = YamlHelper.load_yaml_to_object "casa.yml"
      packages_obj = SOURCES.map do |src|
        [src, yaml.fetch(src, [])]
      end.to_h

      ## Install all packages
      PackageInstaller.install_all_packages packages_obj

      scripts_arr = yaml["scripts"] || []
      # ## Run casa module scripts
      ScriptsRunner.run_scripts scripts_arr
    end
  end
end
