require "fileutils"

# Utils
Dir["/usr/local/Casa/lib/utils/*.rb"].each {|file| require file }

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
  def self.package_manager_exist_and_install command, install_script, not_installed_prompt, force_install=false
    if !system "which #{command} > /dev/null 2>&1" # Surpress system output
      if force_install
        system install_script
        return true
      else
        continue = Prompt.run not_installed_prompt
        if continue
          system install_script
          return true
        else
          return false
        end
      end
    else
      return true
    end
  end

  def self.install_all_packages packages
    ## Installs brew, pip, npm, gems
    # brew_kegs
    if self.package_manager_exist_and_install "brew", "/usr/bin/ruby -e \"$ curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install\"", "", true
      self.install_brew_kegs packages["brew_kegs"]
    else
      puts "Failed to install brew"
      exit # Exit if brew installation fails
    end
    # pip_packages
    if self.package_manager_exist_and_install "pip", "brew insall python", "Pip is not installed. Would you like to install it now?  y/n "
      self.install_pip_packages packages["pip_packages"]
    else
      puts "Failed to install pip"
    end
    # node_modules
    if self.package_manager_exist_and_install "npm", "brew install node", "npm is not installed. Would you like to install it now?  y/n "
      self.install_node_modules packages["node_modules"]
    else
      puts "Failed to install npm"
    end
    # ruby_gems
    self.install_ruby_gems packages["ruby_gems"]
    # casa_modules
    self.install_casa_modules packages["casa_modules"]
  end

  def self.install_brew_kegs args=[]
    if !args.empty?
      system "brew install #{args.join " "}"
    else
      puts "No brew kegs listed."
    end
  end

  def self.install_pip_packages args=[]
    if !args.empty?
      system "pip install #{args.join " "}"
    else
      puts "No pip packages listed."
    end
  end

  def self.install_ruby_gems args=[]
    if !args.empty?
      system "sudo gem install #{args.join " "}"
    else
      puts "No ruby gems listed."
    end
  end

  def self.install_node_modules args=[]
    if !args.empty?
      system "sudo npm install -g #{args.join " "}"
    else
      puts "No node modules listed."
    end
  end

  def self.install_casa_modules args=[]
    if !args.empty?
      system "casa install #{args.join " "}"
    else
      puts "No casa packages listed."
    end
  end
end