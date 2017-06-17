# Create an access list
user1 = User.create(:name => "user1")
user2 = User.create(:name => "user2")

# Generate some initial values
user1.purchase_coffee(Time.parse("2017-01-30 07:00:00 UTC"))
user1.purchase_coffee(Time.parse("2017-01-30 10:00:00 UTC"))
user1.purchase_coffee(Time.parse("2017-02-14 07:00:00 UTC"))
user1.purchase_coffee(Time.parse("2017-03-30 07:00:00 UTC"))

# Make a payment
user1.make_payment(Time.parse("2017-04-16 07:00:0 UTC"), 3)
