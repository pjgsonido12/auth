class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :paid
      t.integer :a
      t.integer :b
      t.integer :c
      t.integer :d
      t.integer :e

      t.timestamps
    end
  end
end
