FROM ruby:3.2.1

COPY . .

RUN bundle install --without development, test

ENTRYPOINT ["bundle", "exec", "puma"]
