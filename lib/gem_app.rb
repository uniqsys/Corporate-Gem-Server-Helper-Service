require 'bundler/setup'
require 'sinatra'
require 'yajl'

require 'gem_exceptions'
require 'gem_manager'

get '/' do
  'This is UNIQ Systems corporate gem server helper service. You are not expected to use it via browser.'
end

post '/gems/new' do
  content_type 'application/json'
  
  response = { :result => 0, :message => 'Gem has been successfully uploaded' }  

  begin
    raise NoFileProvidedGemException.new unless params[:file] && (tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
    
    raise InvalidGemException.new unless gemspec = GemManager.spec(tmpfile.path)
    raise AlreadyInstalledGemException.new if GemManager.is_installed?(gemspec.name, gemspec.version.to_s)

    Tempfile.new([gemspec.name, '.gem']).tap do |tmpgemfile|
      FileUtils.cp(tmpfile.path, tmpgemfile.path)
      GemManager.install(tmpgemfile.path)
      tmpgemfile.close!
    end
  rescue NewGemException => new_gem_exception
    response = { :result => new_gem_exception.code, :message => new_gem_exception.message }
  end

  Yajl::Encoder.encode(response)
end