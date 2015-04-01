require 'pathname'
# TODO
# Move module to lib folder
# Test methods
#
# Will not do it now.
# How will realpath behave?
module Common
  REAL_FILEPATH = "#{Pathname.new(__FILE__).realpath}"
  HOME = ENV['HOME']
  COMMON_FILES = %w(.bash_profile .bashrc .gitconfig .maat .profile .tmux.conf .vim .vimrc bin)

  class << self
    # real absolute path for given common file.
    def common_path(common_file)
      Pathname.new("../../../#{common_file}").expand_path(REAL_FILEPATH)
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
      common_files do |new| 
        begin
          print "Removing file #{new}..." if $VERBOSE
          new.delete 
          puts "done." if $VERBOSE
        rescue Errno::ENOENT
          print "\n\t" if $VERBOSE
          puts "#{$!.message}"
        end
      end
    end
    public :remove!

    # Setup symlink files. Displays error message if file exists.
    def setup
      common_files do |new, common_path| 
        begin
          print "Creating symlink from #{new} to #{common_path}..." if $VERBOSE
          new.make_symlink(common_path) 
          puts "done." if $VERBOSE
        rescue Errno::EEXIST
          print "\n\t" if $VERBOSE
          puts "#{$!.message}"
        end
      end
    end
    public :setup
  end
end


