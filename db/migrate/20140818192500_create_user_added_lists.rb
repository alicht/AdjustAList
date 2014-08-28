class CreateUserAddedLists < ActiveRecord::Migration
  def change
    create_table :user_added_lists do |t|

      t.timestamps
    end
  end
end
