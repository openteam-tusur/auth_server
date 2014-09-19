class AddOldUidToUser < ActiveRecord::Migration
  def change
    add_column :users, :old_uid, :string
  end
end
