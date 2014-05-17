class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :car_id
      t.date :date
      t.integer :mileage
      t.integer :type
      t.text :notes

      t.timestamps
    end
  end
end
