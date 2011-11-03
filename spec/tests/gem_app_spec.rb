require 'yajl'

describe 'Gem server service app' do
  it "turns back unwanted visitors" do
    visit '/'
    page.should have_content(%Q{This is UNIQ Systems corporate gem server helper service. You are not expected to use it via browser.})
  end
  
  it "should accept new gems to submission" do
    post 'gems/new', 'file' => Rack::Test::UploadedFile.new("spec/fixtures/test.gem", "application/binary")

    last_response.should be_ok
    last_response.content_type.should == 'application/json;charset=utf-8'
    
    result = Yajl::Parser.parse(last_response.body)
    result['result'].should == 0
    result['message'].should == 'Gem has been successfully uploaded'
  end
end