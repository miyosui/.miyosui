#!/usr/bin/env ruby

require 'pathname'

__REALPATH__ = "#{Pathname.new(__FILE__).realpath}"
__HOME__ = ENV['HOME']

DOTFILES = %w(.vimrc .bashrc .profile .bash_profile .gitconfig bin)

# create symbolic link between list of files and $HOME directory
DOTFILES.each do |dotfile|
  old = Pathname.new("../../#{dotfile}").expand_path(__REALPATH__)
  new = Pathname.new("#{__HOME__}/#{dotfile}")
  new.make_symlink(old) unless new.symlink?
end
