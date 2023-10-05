# syntax = docker/dockerfile:1

FROM ruby:slim as base

RUN apt-get update &amp;&amp;\
    apt-get install --yes git curl build-essential

RUN curl -sL https://deb.nodesource.com/setup_current.x | bash - &amp;&amp;\
    apt-get update &amp;&amp; \
    apt-get install --yes --no-install-recommends nodejs &amp;&amp;\
    npm install -g yarn

FROM base as build

RUN gem install bundler -v 2.4.17

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . /app

FROM base

WORKDIR app
COPY --from=build /app /app
COPY --from=build /usr/local/bundle /usr/local/bundle

COPY &lt;&lt;-&quot;EOF&quot; /app/config/routes.rb
Rails.application.routes.draw { root &quot;rails/homepage#index&quot; }
EOF

ENV RAILS_ENV=production
RUN bin/rails assets:precompile
EXPOSE 3000
CMD bin/rails server
