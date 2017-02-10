class CreateBeersTable < ActiveRecord::Migration[5.0]

  def up
    create_table :beers do |t|
      t.string :name
      t.string :kind
      t.string :description
      t.integer :rating
      t.belongs_to :brewery, :foreign_key => 'breweries.id'
    end
  end

  def down
    drop_table :beers
  end

end
