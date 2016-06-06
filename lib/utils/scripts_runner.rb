require "fileutils"

# Import all utils
Dir["/usr/local/Casa/lib/utils/*.rb"].each {|file| require file }

#################################
##### Helper: scripts_runner #####
#################################

### Docs ###
#
# Used during the `$ casa furnish` command for iterating through
# the specified scripts and running them.
#
# Checks for script type and uses correct command.

#################################
#################################
#################################

module ScriptsRunner
  def self.run_scripts scripts=[]
    ## Run Scripts - iterate through scripts
    scripts.each { |i|
      command = self.return_command_for_extension i
      # If valid commmand was returned
      if command
        system "#{command} #{FileUtils.pwd }/scripts/#{i}"
      end
    }
  end

  def self.return_command_for_extension script
    extension = File.extname script

    puts case extension
    when ".sh"
      return "sh"
    when ".js"
      return "node"
    when ".rb"
      return "ruby"
    when ".py"
      return "python"
    else
      puts "The script \"#{script}\" could not be run because #{extension} is an invalid extension to run."
      return false
    end
  end
end