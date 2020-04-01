FROM ruby:2.6.3

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN npm install -g yarn
RUN gem install bundler --version 2.1.4

WORKDIR /portal-solar-dev-test
COPY Gemfile /portal-solar-dev-test/Gemfile
COPY Gemfile.lock /portal-solar-dev-test/Gemfile.lock
RUN bundle install
COPY . /portal-solar-dev-test

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]