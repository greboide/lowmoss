require 'rails_helper'
describe "Home page" do
  it "entra na home" do
    visit root_path
    page.has_content?('Lorem')
  end
end
