require "fileutils"

#################################
##### Helper: uninstaller #######
#################################

### Docs ###
#
# Removes Casa associated directories

#################################
#################################
#################################

module Uninstall
  def self.run args=[]
    puts "Deleting Casa and all associated modules..."

    FileUtils.rmdir("/usr/local/Casa")
    FileUtils.rmdir("/usr/local/Palacio")
  end
end
