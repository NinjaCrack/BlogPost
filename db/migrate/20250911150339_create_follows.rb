class CreateFollows < ActiveRecord::Migration[8.0]
  def change
    create_table :follows do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :follows, :follower_id # Add index for faster lookup
    add_index :follows, :followed_id # Add index for faster lookup
    add_index :follows, [:follower_id, :followed_id], unique: true # Ensure a user can't follow the same user more than once
  end
end
