class CreateBreweriesTable < ActiveRecord::Migration[5.0]

  def up
    create_table :breweries do |t|
      t.string :name
      t.string :location
    end
  end

  def down
    drop_table :breweries
  end

end
