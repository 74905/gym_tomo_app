class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :image_id
      t.text :introduction
      t.string :zipcode
      t.string :address
      t.string :phone_number
      t.float :latitude
      t.float :longitude
      
      t.timestamps
    end
  end
end
