module Decorator
  class Tweet
    attr_reader :tweet

    def initialize(tweet)
      @tweet = tweet
    end

    def tweet_content
      tweet.tweet
    end

    def tweet_timestamp
      tweet.timestamp.to_formatted_s(:short)
    end

  end
end