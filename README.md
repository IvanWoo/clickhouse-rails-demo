# rails-clickhouse-demo

## env

```sh
rbenv install 2.7.2
rbenv local 2.7.2
gem install rails -v 6.0.4.3
rails _6.0.4.3_ new ch-demo
```

## install

go to the rails app folder

```sh
cd ch-demo
```

```sh
bundle add click_house
```

## [config](https://github.com/shlima/click_house#using-with-rails)

```sh
rake click_house:drop click_house:create
rake click_house:drop click_house:create RAILS_ENV=production
```

## test

```sh
bundle exec rails c
```

```ruby
ClickHouse.connection.ping #=> true
```

### select

```ruby
ClickHouse.connection.select_all('SELECT * FROM events_local')
```

### explain

```ruby
ClickHouse.connection.explain('SELECT * FROM events_local')
```

### Execute Raw SQL

need to parse the raw response, might not be the best way

```ruby
response = ClickHouse.connection.execute <<~SQL
  SELECT count(*) AS count FROM events_local
SQL

response.body #=> "0\n"
```
