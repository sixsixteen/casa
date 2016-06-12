#!/usr/bin/env ruby

require "fileutils"

CASA_DIR = "/usr/local/Casa"
CASA_REPO = "https://github.com/sixsixteen/casa.git"

CASA_MODULES_DIR = "/usr/local/Palacio"

##########################
#### Casa Installer ######
##########################

### Docs ###
#
# This installs Casa globally. It does this by creating the /usr/local/Casa and the /usr/local/Palacio directories and cloning
# Casa into /usr/local/Casa.
#

##########################
##########################
##########################

module Install
  def self.run
    puts "Preparing to install Casa..."

    # Check to see if Casa has already been installed
    # REVIEW: I try to avoid multiple whitespace-separated
    # expressions on the same line, makes it confusing to
    # read for people that don't know what the precedence
    # rules are
    if Dir.exist?(CASA_DIR) || Dir.exist?(CASA_MODULES_DIR)
      puts "Casa is already installed. Would you like to reinstall? (y/n) "
      continue = gets.chomp
      if continue == "y"
        puts "Reinstalling Casa..."
        FileUtils.rm_rf CASA_DIR
        FileUtils.rm_rf CASA_MODULES_DIR
      else
        abort "Aborting installation."
      end
    end

    # REVIEW: You don't need to write `self.` before calling
    # a module / classes own methods
    create_casa_directories

    clone_casa

    configure_casa_shell_command
  end

  def self.create_casa_directories
    FileUtils.mkdir CASA_DIR, :mode => 0755
    FileUtils.mkdir CASA_MODULES_DIR, :mode => 0755
  end

  def self.clone_casa
    # REVIEW: I don't like it, but `unless` is idiomatic
    # ruby
    unless system "git clone #{CASA_REPO} #{CASA_DIR}"
      abort "Downloading Casa failed. :("
    end
  end

  def self.configure_casa_shell_command
    # Execution permissions
    FileUtils.chmod 0755, "#{CASA_DIR}/lib/casa/casa.rb"

    # Copy contents to extensionless file
    FileUtils.cp "#{CASA_DIR}/lib/casa/casa.rb", "#{CASA_DIR}/lib/casa/casa"

    # Link Command, force if file exists
    FileUtils.ln_s "#{CASA_DIR}/lib/casa/casa", "/usr/local/bin/", :force => true
  end
end

Install.run
