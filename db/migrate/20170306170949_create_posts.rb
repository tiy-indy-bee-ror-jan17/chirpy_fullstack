class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :chirps do |t|
      t.string :body
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
