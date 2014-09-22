class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.uuid :user_id, index: true
      t.string :identity_id

      t.timestamps
    end
  end
end
