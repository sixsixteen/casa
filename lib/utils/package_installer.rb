require "fileutils"

Dir["#{__dir__}/package_installer/*.rb"].each { |file| require file }

######################################
##### Helper:  package_installer #####
######################################

### Docs ###
#
# This manages installing specified brew packages, node modules, etc.
# Also can check for existence of those package managers on the local machine.

######################################
######################################
######################################

module PackageInstaller
  MANAGERS = [
    BrewPackageManager.new,
    StandardPackageManager.new("pip", "pip_packages"),
    StandardPackageManager.new("node", "node_modules"),
    StandardPackageManager.new("gem", "ruby_gems", :needs_install => false),
    StandardPackageManager.new("casa", "casa_modules", :needs_install => false)
  ]

  def self.install_all_packages packages
    MANAGERS.each do |manager|
      if manager.exist_and_install
        key = manager.config_key
        manager.install_packages packages[key]
      else
        puts "Failed to install #{manager.manager_name}"
      end
    end
  end
end
