class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :Name
      t.string :username
      t.string :email
      t.text :bio
      t.string :gender
      t.string :password_digest

      t.timestamps
    end
  end
end
