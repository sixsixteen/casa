require "erb"
require "yaml"
require "fileutils"

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
    until (type == "config") || (type == "module")
      type = prompt_for_config_type
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
    template = File.read "#{__dir__}/../misc/casa_yaml_template.yml.erb"
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
    YAML.load_file path
  end

  def self.prompt_for_config_type
    answer = Prompt.run "Type must either be config or module. Enter a type  or \"exit\" to exit: "

    case answer
    when "config"
      "config"
    when "module"
      "module"
    when "exit"
      abort "Aborting intialization"
    end
  end
end
