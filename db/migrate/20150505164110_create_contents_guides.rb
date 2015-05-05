class CreateContentsGuides < ActiveRecord::Migration
  def change
    create_table :contents_guides do |t|
      t.references :content, index: true, foreign_key: true
      t.references :guide, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
