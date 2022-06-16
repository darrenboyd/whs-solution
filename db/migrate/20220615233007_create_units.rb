class CreateUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :units do |t|
      t.string :unit_number, null: false
      t.string :floor_plan, null: false
      t.string :resident
      t.date :move_in
      t.date :move_out

      t.timestamps
    end
  end
end
