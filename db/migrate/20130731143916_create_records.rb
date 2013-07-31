class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
			t.integer :car_id
      t.date :date
      t.integer :mileage
      t.float :gallons
      t.float :cost

      t.timestamps
    end
  end
end
