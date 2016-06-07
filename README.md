# Casa

Casa is a simple tool that helps you organize and maintain your developer environment. It does so by recommending a simple structure for how to modularize your configuration and providing a few helper set up scripts.

## Installation

Run: `$ ruby -e "$(curl --user [YOUR_GITHUB_USER_NAME] https://raw.githubusercontent.com/sixsixteen/casa/master/lib/casa/installer.rb)"`

Now run, `$ casa help` and you should see a list of commands.

## Usage

There are a few basic commands in Casa:

* `$ casa help` will show you the list of Casa commands.
* `$ casa init`, when run in an empty directory, will set up a simple casa.yml and the files/ and scripts/ directories.
* `$ casa furnish`, when run in a directory with a `casa.yml` file, installs the specified packages, and runs your scripts.

Check out the example folder on this repo to see what a configuration could look like and how to configure a `casa.yml` file.

Beyond that are the files/ and scripts/ directories which are simply there to organize any files you want to maintain in each development environment, and the list of scripts you want to run when configuring the set up (linking dotfiles, installing fonts, etc).

## Contributing

The recommended install method is to use the install script above and work out of the `/usr/local/Casa` directory. Many of the Casa commands are hard coded to use `/usr/local/Casa` for tasks so cloning into a different directory and working out of there requires some minor changes to the code. If you are working on the `casa.rb` file, don't forget to relink it after changes. You can run `$ sh lib/scripts/relink_command` any time you've changed `casa.rb` and the `$ casa` command will be updated.

Feel free to open issues or email questions!