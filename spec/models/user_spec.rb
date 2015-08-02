require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    FactoryGirl.create(:user ).should be_valid
  end
  it "is has a name taken from email" do
    user = FactoryGirl.build(:user, email: "meunome@teste.com.br")
    expect(user.name).to eq('@meunome')
  end
 pending "add some examples to (or delete) #{__FILE__}"
end
