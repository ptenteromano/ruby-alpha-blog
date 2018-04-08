class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    # added a default to parameters
    add_column :users, :admin, :boolean, default: false
  end
end
