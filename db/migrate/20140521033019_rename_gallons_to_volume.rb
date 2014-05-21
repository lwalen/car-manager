class RenameGallonsToVolume < ActiveRecord::Migration
  def change
		rename_column :records, :gallons, :volume
  end
end
