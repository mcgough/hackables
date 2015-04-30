class CreateGuidesTags < ActiveRecord::Migration
  def change
    create_table :guides_tags do |t|
      t.references :guide, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
