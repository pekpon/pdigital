class CreateCommerces < ActiveRecord::Migration
  def change
    create_table :commerces do |t|
      t.string :slug
      t.string :name
      t.string :street
      t.string :telephone
      t.string :time
      t.string :email
      t.text :map_code
      t.boolean :active
      t.boolean :pro

      t.timestamps
    end
  end
end
