describe 'The HelloWorld App' do
  it "says hello" do
    visit '/'
    page.should have_content('Hello World')
  end
end