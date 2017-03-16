class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true
      # commentable_id (INT)
      # commentable_type (String)
      t.references :user, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
