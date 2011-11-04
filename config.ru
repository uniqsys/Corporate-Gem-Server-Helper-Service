$:<< File.join(File.dirname(__FILE__), "lib")

require 'rack/reverse_proxy'
require 'gem_app'

use Rack::ReverseProxy do 
  reverse_proxy /\/(?!api\/).*/, 'http://127.0.0.1:8808/'
end

run Sinatra::Application
