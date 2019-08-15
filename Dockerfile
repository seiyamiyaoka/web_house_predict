FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y nodejs mysql-client

# throw errors if Gemfile has been modified since Gemfile.lock
# 左がローカルのファイル右がcontainerのファイル
# https://techblog.recochoku.jp/1979
ENV BUNDLER_VERSION 2.0.1
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler -v 2.0.1
RUN bundle version
RUN bundle install


# RUN bundle install
COPY . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]