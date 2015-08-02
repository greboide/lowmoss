class AddOriginalPostToPost < ActiveRecord::Migration
  def change
    add_reference :posts, :original_post, index: true
  end
end
