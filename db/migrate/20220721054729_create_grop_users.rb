class CreateGropUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :grop_users do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
