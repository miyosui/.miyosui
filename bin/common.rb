#!/usr/bin/env ruby

require 'pathname'

module Common
  REAL_FILEPATH = "#{Pathname.new(__FILE__).realpath}"
  HOME = ENV['HOME']
  COMMON_FILES = %w(.bash_profile .bashrc .gitconfig .profile .tmux.conf .vimrc bin)

  class << self
    # real absolute path for given common file.
    def common_path(common_file)
      Pathname.new("../../#{common_file}").expand_path(REAL_FILEPATH)
    end
    private :common_path

    # run code based on common files
    def common_files(&block)
      COMMON_FILES.each do |common_file|
        case block.arity
        when 1
          yield new(common_file)
        when 2
          yield new(common_file), common_path(common_file)
        end
      end
    end
    private :common_files

    # Name of symlink to be created/removed
    def new(common_file)
      Pathname.new("#{HOME}/#{common_file}")
    end
    private :new

    # Remove new files even if they are not symlinks.
    def remove!
      common_files { |new| new.delete }
    end
    public :remove!

    # Setup symlink files. Displays error message if file exists.
    def setup
      common_files do |new, common_path| 
        begin
          new.make_symlink(common_path) 
        rescue Errno::EEXIST
          puts $!.message
        end
      end
    end
    public :setup
  end
end

if __FILE__ == $0
  module Message
    class << self
      # NOTE
      # exit == exit 0 == exit(true) ==> exit successfuly execution with status true
      # exit 1 == exit(false) ==> abort execution with status false
      # exit! ==> abort execution with status false
      # exit! ==> skip at_exit block
      # abort ==> abort execution with status false
      # abort ==> send message to stderr
      def help
        puts "Usage: #{$0} {setup|remove!}"
        exit 0
      end
      public :help
    end
  end
  Message.help unless %w(setup remove!).include?(ARGV[0])
  Common.send(ARGV[0])
end


