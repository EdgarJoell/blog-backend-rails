class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts, force: :cascade do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :content
      t.boolean :published, default: false, null: false
      t.boolean :is_latest, default: true, null: false

      t.timestamps
    end
  end
end
