class AddAuthorToPosts < ActiveRecord::Migration[8.0]
  def change
    add_reference :posts, :author, null: false, foreign_key: true
  end
end
