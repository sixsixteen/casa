require "erb"
require "yaml"
require "fileutils"

# Import all utils
Dir["/usr/local/Casa/lib/utils/*.rb"].each { |file| require file }

#################################
##### Helper: uninstaller #######
#################################

### Docs ###
#
# Utility methods for reading and creating yaml files. Used in:
#   - $ casa init
#   - $ casa furnish

#################################
#################################
#################################

## Helper class for binding to ERB template
class ConfigFileClass
  attr_accessor :type, :name, :repo
  def template_binding
    binding
  end
end

module YamlHelper
  def self.build_yml_file type
    # Type
    while ! type == "config" || type == "module" do
      type = self.prompt_for_config_type
    end

    # Name
    name = Prompt.run "Do you want to name the #{type}?  Defaults to \"casa_config\" "
    if name.empty?
      name = "#{FileUtils.pwd}"
    end

    # Repo
    repo = Prompt.run "Enter the Github URL associated with this #{type}? Optional. "

    # Create file from casa_yaml_template with values
    new_file = File.open "#{FileUtils.pwd}/casa.yml", "w+"
    template = File.read "/usr/local/Casa/lib/misc/casa_yaml_template.yml.erb"
    config = ConfigFileClass.new
    config.type = type
    config.name = name
    config.repo = repo
    temp = ERB.new template
    results = temp.result config.template_binding
    new_file << results
    new_file.close
  end

  def self.load_yaml_to_object path
    return YAML.load_file path
  end

  def self.prompt_for_config_type
    answer = Prompt.run "Type must either be config or module. Enter a type  or \"exit\" to exit: "

    puts case answer
    when "config"
      return "config"
    when "module"
      return "module"
    when "exit"
      abort "Aborting intialization"
    else
      return nil
    end
  end
end
