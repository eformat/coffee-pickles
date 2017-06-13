# Coffee Pickles

## Description

Coffee Pickles tracks users' coffee consumption over time. The application also shows charts for the following:

* Bar graph showing the days the user drinks coffee;
* Timeline of the user's coffee activity.

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
$ bundle exec shotgun -o 0.0.0.0 -p 5000 config.ru

```

