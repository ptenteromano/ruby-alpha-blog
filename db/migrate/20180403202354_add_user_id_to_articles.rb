class AddUserIdToArticles < ActiveRecord::Migration[5.1]
  def change
    # foreign key user_id is an integer type
    add_column :articles, :user_id, :integer  
  end
end
