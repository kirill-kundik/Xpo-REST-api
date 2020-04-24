FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

ARG RAILS_ENV
ENV RAILS_ENV $RAILS_ENV
ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

RUN bundle install

COPY . $APP_HOME

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD puma -C config/puma.rb