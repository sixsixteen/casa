require "fileutils"

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
    scripts.each do |i|
      command = return_command_for_extension i
      # If valid commmand was returned
      if command
        system "#{command} #{FileUtils.pwd }/scripts/#{i}"
      end
    end
  end

  def self.return_command_for_extension script
    extension = File.extname script

    case extension
    when ".sh"
      "sh"
    when ".js"
      "node"
    when ".rb"
      "ruby"
    when ".py"
      "python"
    else
      puts "The script \"#{script}\" could not be run because #{extension} is an invalid extension to run."
      false
    end
  end
end
