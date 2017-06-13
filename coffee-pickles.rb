require 'sinatra'
require 'chartkick'
require 'sinatra/flash'
require 'sinatra/activerecord'
require './models/user'
require './models/coffee'
require './models/payment'

set :database_file, 'config/database.yml'
enable :sessions

get '/' do
  @user = find_user("user1")

  # create variables for graphs
  @coffeedays = {"Sunday" => 0, "Monday" => 0, "Tuesday" => 0,
                "Wednesday" => 0, "Thursday" => 0, "Friday" => 0,
                "Saturday" => 0}
  @coffeeline = Hash.new(0)

  coffees = Coffee.where(:user_id => @user.id)
  coffees.each do |coffee|
    date = coffee.purchased
    @coffeedays[date.strftime('%A')] += 1
    @coffeeline[date] += 1
  end

  @all_time = coffees.count

  erb :profile
end

post '/coffee' do
  date = Time.now.getlocal('+10:00')
  user = find_user("user1")
  user.coffees.create(purchased: date).save
  user.balance += 1
  user.save
  redirect "/"
end

# Update the find and create to use the common name (CN)
# passed in from the user's PKI
def find_user(name)
  user = User.find_by_name(name)
  if user.nil?
    user = User.new(name: name)
    user.save
  end
  return user
end
