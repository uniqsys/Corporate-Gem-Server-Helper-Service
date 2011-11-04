require 'escape'

class GemManager
  class << self
    def install(gem_file_name)
      gem_response("install", gem_file_name, "--no-ri", "--no-rdoc")
    end
    
    def spec(gem_file_name)
      YAML::load(gem_response("specification", gem_file_name))
    end
    
    def is_installed?(gem_name, version=nil)
      cmd_parts = [ "list", gem_name, "-i" ]
      cmd_parts << "-v" << version if version
      gem_response(*cmd_parts) == 'true'
    end
    
    def uninstall(gem_name, version=nil)
      cmd_parts = [ "uninstall", gem_name ]
      cmd_parts << "-v" << version if version
      gem_response(*cmd_parts)
    end
    
    def empty!
      system "source ~/.rvm/environments/ruby-1.9.2-p290@gemserver && rvm --force gemset delete gemserver"
      system "rvm --create 1.9.2@gemserver"
    end
    
  private
  
    def gem_response(*args)
      lines = `#{gem(*args)}`
      lines.split("\n")[1,256].join("\n")
    end
  
    def gem(*args)
      "bash -l -c " + Escape.shell_single_word("source ~/.rvm/environments/ruby-1.9.2-p290@gemserver && " + Escape.shell_command(["gem", *args]) + " 2>/dev/null").to_s
    end
    
  end  
end