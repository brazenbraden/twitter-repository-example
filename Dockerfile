FROM ruby:2.2.3

RUN apt-get update && apt-get install -y nodejs build-essential --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Setup working directory
RUN mkdir /app
WORKDIR /app
ADD . ./
RUN bundle install --system
VOLUME /app
