class CreateDistances < ActiveRecord::Migration[5.2]
  def change
    create_table :distances do |t|
      t.string :origin
      t.string :destination
      t.decimal :distance

      t.timestamps
    end
  end
end
