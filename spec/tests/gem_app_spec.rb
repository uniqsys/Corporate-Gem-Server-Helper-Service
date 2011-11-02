describe 'Gem server service app' do
  it "turns back unwanted visitors" do
    visit '/'
    page.should have_content(%Q{This is UNIQ Systems corporate gem server helper service. You are not expected to use it via browser.})
  end
end