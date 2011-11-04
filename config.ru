$:<< File.join(File.dirname(__FILE__), "lib")

require 'rack/reverse_proxy'
require 'gem_app'

class ApiRegex < Regexp
  def initialize
    super('')
  end
  
  def match(what)
    /^\/api\/.*/.match(what) ? false : true
  end
end

use Rack::ReverseProxy do 
  reverse_proxy ApiRegex.new, 'http://127.0.0.1:8808/'
end

run Sinatra::Application
