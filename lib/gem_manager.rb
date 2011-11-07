require 'escape'

RVM_PATH="/usr/local/rvm"
RUBY_VERSION="ree-1.8.7-2011.03"

# RVM_PATH="/Users/sky/.rvm"
# RUBY_VERSION="ruby-1.9.2-p290"

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
      system "source #{RVM_PATH}/environments/#{RUBY_VERSION}@gemserver && rvm --force gemset delete gemserver"
      system "rvm --create #{RUBY_VERSION}@gemserver"
    end
    
  private
  
    def gem_response(*args)
      `#{gem(*args)}`
    end
  
    def gem(*args)
      "env - bash -c " + Escape.shell_single_word("source #{RVM_PATH}/environments/#{RUBY_VERSION}@gemserver && " + Escape.shell_command(["gem", *args]) + " 2>/dev/null").to_s
    end
    
  end  
end