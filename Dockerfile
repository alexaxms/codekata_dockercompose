FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs
ENV RAILS_ROOT /codekata
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler:2.0.2
RUN bundle install
# Adding project files
COPY . .
RUN npm install -g yarn
RUN yarn install --check-files
COPY config/database.yml.docker config/database.yml
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD rails server -p 3000 -b '0.0.0.0'