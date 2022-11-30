FROM ruby:3.1.0

COPY . .

RUN bundle install --without development, test

ENTRYPOINT ["bundle", "exec", "rackup"]
