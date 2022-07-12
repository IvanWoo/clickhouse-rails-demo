# clickhouse-rails-demo

## env

```sh
rbenv install 2.7.2
rbenv local 2.7.2
gem install rails -v 6.0.4.3
rails _6.0.4.3_ new clickhouse-rails-demo
```

## install

go to the rails app folder

```sh
cd clickhouse-rails-demo
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
ClickHouseConnection.instance.ping #=> true
```

### select

```ruby
ClickHouseConnection.instance.select_all('SELECT * FROM events_local')
```

### explain

```ruby
ClickHouseConnection.instance.explain('SELECT * FROM events_local')
```

### Execute Raw SQL

need to parse the raw response, might not be the best way

```ruby
response = ClickHouseConnection.instance.execute <<~SQL
  SELECT count(*) AS count FROM events_local
SQL

response.body #=> "100\n"
```

## hack with ActiveRecord

create the empty tables on sqlite3

```sh
bundle exec rails db:migrate
```

```sh
bundle exec rails c
```

```ruby
EventsLocal.where(article_id: 42).select_one
```

```
SQL (Total: 5MS, CH: 1MS)[0m SELECT "events_local".* FROM "events_local" WHERE "events_local"."article_id" = 42 FORMAT JSON;;
                                                                                                                             Read: 100 rows, 2.6KiB. Written: 0 rows, 0B
=> {"event_date"=>Tue, 21 Jun 2022, "event_type"=>0, "article_id"=>42, "title"=>"my title"}
```
