require "fileutils"
require "optparse"

# Import all utils
Dir["/usr/local/Casa/lib/utils/*.rb"].each { |file| require file }

##########################
#### Command: init #######
##########################

### Docs ###
#
# This creates a project strucutre for a casa config. It generates a yml file
# and two empty directories: "files" and "scripts"
# 

### Options ###
class Parser
  @options_struct = Struct.new :name

  def self.parse options
    args = @options_struct.new "init"

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: casa init [TYPE] [OPTIONS]"
      opts.separator  ""
      opts.separator  "Specifier"
      opts.separator  "     type: config | module"
      opts.separator  ""
      opts.separator  "Options"

      opts.on "-h", "--help", "Prints init command help" do
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

module Init
  def self.run args=[]
    # Is current directory already a config/module?
    if File.exist? "casa.yml" then abort "There is already a casa.yml file present. You must be in an empty directory." end

    # Build yaml file
    YamlHelper.build_yml_file args[0]

    # Add empty dotfiles and scripts dirs
    self.add_files_and_scripts_dirs
  end

  def self.add_files_and_scripts_dirs
    FileUtils.mkdir "#{FileUtils.pwd }/files", :mode => 0777
    FileUtils.mkdir "#{FileUtils.pwd }/scripts", :mode => 0777
  end
end
