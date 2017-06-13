class CreateCoffees < ActiveRecord::Migration[5.1]
  def change
    create_table :coffees do |t|
      t.datetime :purchased
      t.integer  :user_id
    end
  end
end
