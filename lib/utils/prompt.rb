##########################
##### Helper: prompt #####
##########################

### Docs ###
#
# Helper function for "prompt" like functionality. Takes text and returns
# entered answer
#
# Usage:
#   answer = Prompt.run "Yes or no: "

##########################
##########################
##########################

module Prompt
  def self.run *args
    print(*args)
    STDIN.gets.chomp
  end
end
