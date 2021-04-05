class Application < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :street_adress
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :pitch
      t.string :progress

      t.timestamps
    end
  end
end
