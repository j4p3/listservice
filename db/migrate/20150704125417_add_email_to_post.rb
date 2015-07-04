class AddEmailToPost < ActiveRecord::Migration
  def up
    add_column :posts, :email, :string
    Post.each do |post|
      offset = post.body.rindex('@')
      email = post.body.slice(post.body.rindex(/\n/, 250),
              post.body.index(/\n/, 250)).strip
      post.update(email: email)
    end
  end

  def down
    remove_column :posts, :email
  end
end
