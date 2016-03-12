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
      tweet.created_at.to_formatted_s(:short) if tweet.created_at.present?
    end

  end
end