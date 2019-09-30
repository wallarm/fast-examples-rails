FROM ruby:2.6.1

RUN mkdir /app

WORKDIR /app

COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY ./app/ /app/app/
COPY ./bin/ /app/bin/
COPY ./config/ /app/config/
COPY ./db/ /app/db/
COPY ./lib/ /app/lib/
COPY ./log/ /app/log/
COPY ./public/ /app/public/
COPY ./spec/ /app/spec/
COPY ./storage/ /app/storage/
COPY ./tmp/ /app/tmp/

COPY ./Rakefile /app/Rakefile
COPY ./config.ru /app/config.ru
COPY ./.rspec /app/.rspec

RUN bundle exec rails db:migrate
ENTRYPOINT ["bundle", "exec"]
CMD ["rails s"]
