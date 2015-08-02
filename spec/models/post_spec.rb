require 'rails_helper'

RSpec.describe Post, :type => :model do
  it "has a valid factory" do
    FactoryGirl.build(:post ).should be_valid
  end
  it "is invalid without body" do
    FactoryGirl.build(:post, body: nil).should_not be_valid
  end
  it "can be a comment" do
    user = FactoryGirl.build(:user)
    post = FactoryGirl.build(:post, user: user )
    comment = FactoryGirl.create(:post, original_post: post, user: user)
    expect(comment).to be_valid
    #expect(Post).to respond_to(:comment)
    expect(Post.all.count).to be > 0
    expect(Post.comments.count).to be > 0
  end
end
