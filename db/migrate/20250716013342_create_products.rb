class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.text :name
      t.text :description
      t.decimal :price
      t.integer :stock
      t.integer :status
      t.string :image_url
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
