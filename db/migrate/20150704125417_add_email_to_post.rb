class AddEmailToPost < ActiveRecord::Migration
  def up
    add_column :posts, :email, :string
  end

  def down
    remove_column :posts, :email
  end
end

