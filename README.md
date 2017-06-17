# Coffee Pickles

## Description

Coffee Pickles tracks users' coffee consumption over time. The application also shows charts for the following:

* Bar graph showing the days the user drinks coffee;
* Timeline of the user's coffee activity.

The application makes the assumption that a coffee costs $1.

## Developer notes

Software Collections (SCL- https://www.softwarecollections.org) can be used to quickly get a development environment running.

```
$ git clone https://github.com/jockey10/coffee-pickles
$ cd coffee-pickles
$ yum install rh-ruby23
$ scl enable rh-ruby23 bash
$ gem install bundler
$ bundle install --without production
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
$ bundle exec thin -R config.ru -p 5000 -a 0.0.0.0 start
```

You can also access the irb console for the application:

```
$ bundle exec irb -r ./coffee-pickles.rb
irb(main):001:0> user = User.where(:id => 2)
D, [2017-06-14T07:00:21.228401 #32347] DEBUG -- :   User Load (0.1ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<User id: 2, name: "user1", balance: 11>]>
```
