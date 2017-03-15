class AddPhotoToChirps < ActiveRecord::Migration[5.0]
  def change
    add_column :chirps, :photo, :string
  end
end
