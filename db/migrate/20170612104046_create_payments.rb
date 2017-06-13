class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.datetime :date
      t.integer :user_id
    end
  end
end
