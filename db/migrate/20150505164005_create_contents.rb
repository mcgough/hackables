class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :name
      t.string :url
      t.text :desc
      t.text :img

      t.timestamps null: false
    end
  end
end
