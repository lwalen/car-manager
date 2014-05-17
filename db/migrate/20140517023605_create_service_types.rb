class CreateServiceTypes < ActiveRecord::Migration
  def change
    create_table :service_types do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
