class AddSlugToCar < ActiveRecord::Migration
  def change
    add_column :cars, :slug, :string
  end
end
