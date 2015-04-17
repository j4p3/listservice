class AddSentDateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sent_date, :datetime, unique: true
    remove_column :posts, :date
  end
end
