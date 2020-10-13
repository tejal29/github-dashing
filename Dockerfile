FROM library/ruby:2.3.0

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs

RUN mkdir /dashboard
WORKDIR /dashboard

# Copy Gemfile and Gemfile.lock
COPY Gemfile /dashboard/

# Speed up nokogiri install
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES 1
ENV BUNDLER_VERSION=2.1.4

RUN gem install bundler -v 2.0.2
RUN gem update bundler
RUN bundle install

EXPOSE 3030

COPY . /dashboard
# COPY assets /dashboard/assets
CMD dashing start -p 3030 --quiet --address 0.0.0.0
