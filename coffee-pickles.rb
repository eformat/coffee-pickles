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
  begin
    # TODO: Update the find user params to retrieve the
    # PKI common name from request headers
    @user = find_user("user1")
    if @user.nil?
      raise UnauthorizedUser
    end

    # create variables for graphs
    @coffeedays = {"Sunday" => 0, "Monday" => 0, "Tuesday" => 0,
                  "Wednesday" => 0, "Thursday" => 0, "Friday" => 0,
                  "Saturday" => 0}
    @coffeeline = Hash.new(0)
    @payments = @user.payments.last(3).reverse

    coffees = @user.coffees
    coffees.each do |coffee|
      date = coffee.purchased
      @coffeedays[date.getlocal.strftime('%A')] += 1
      @coffeeline[date.getlocal.strftime('%F')] += 1
    end

    @all_time = coffees.count

    erb :profile

  rescue UnauthorizedUser
    content_type 'text/plain'
    [401, 'You are not authorized to access this application']

  end

end

post '/coffee' do
  date = Time.now.getlocal('+10:00')
  user = find_user("user1")
  user.purchase_coffee(date)
  redirect "/"
end

post '/payment' do
  # get the amount from the text-box
  amount = Integer(params[:payment]) rescue false
  if (amount and amount > 0 )
    date = Time.now.getlocal('+10:00')
    user = find_user("user1")
    user.make_payment(date,amount)
    flash[:info] = "Payment successful"
    redirect "/"
  else
    flash[:error] = "Enter a positive integer amount for payment"
    redirect "/"
  end
end

# TODO: Update the find_user method to return a user
# object based on the common name obtained from the PKI
def find_user(user)
  return User.find_by_name(user)
end

# A custom exception for unauthorized users
class UnauthorizedUser < StandardError
  def initialize(msg="Unauthorized user")
    super(msg)
  end
end
