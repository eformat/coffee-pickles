class User < ActiveRecord::Base
  has_many :coffees
  has_many :payments

  def purchase_coffee(date)
    self.coffees.create(purchased: date).save
    self.balance += 1
    self.save
  end

  def make_payment(date,amount)
    self.payments.create(amount: amount, date: date).save
    self.balance -= amount
    self.save
  end
end
