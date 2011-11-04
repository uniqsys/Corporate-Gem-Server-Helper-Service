require 'yajl'

describe 'Gem server service app' do
  before(:each) do
    GemManager.empty!
  end
  
  it "turns back unwanted visitors" do
    visit '/'
    page.should have_content(%Q{This is UNIQ Systems corporate gem server helper service. You are not expected to use it via browser.})
  end
  
  def post_gem_file(file_base_name)
    post 'gems/new', 'file' => Rack::Test::UploadedFile.new("spec/fixtures/#{file_base_name}", "application/binary")

    last_response.should be_ok
    last_response.content_type.should == 'application/json;charset=utf-8'
    
    Yajl::Parser.parse(last_response.body)
  end
  
  it "should accept new valid gems to submission" do
    result = post_gem_file('valid.gem')
    
    result['result'].should == 0
    result['message'].should == 'Gem has been successfully uploaded'    
    GemManager.is_installed?('magic_encoding', '0.0.2').should == true
  end
  
  it "should not allow installation of the same gem twice" do
    post_gem_file('valid.gem')

    result = post_gem_file('valid.gem')
    result['result'].should == 3
    result['message'].should == 'This gem is already installed in the repository'
  end
  
  it "should detect invalid gems" do
    result = post_gem_file('invalid.gem')
    result['result'].should == 2
    result['message'].should == 'Invalid gem has been provided'
  end
end