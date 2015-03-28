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
      #puts "Usage: #{$0} {setup|remove!}"
      yield
      exit 0
    end
    public :help
  end
end

