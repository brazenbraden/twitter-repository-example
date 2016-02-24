module MemoryRepository
  class TweetRepository

    def initialize(params = {})
      @records = {}
      @id = 0
      @temp_tweet_params = params
    end

    def all
      @records
    end

    def create(params = {})
      tweet = build_entity(params.merge(id: @id + 1))
      @records[@id] = tweet
      @id += 1
      tweet
    end

    def save
      if @temp_tweet_params.present?
        tweet = build_entity(@temp_tweet_params.merge!(id: @id + 1))
        @records[@id] = tweet
        @id += 1
        tweet
      end
    end

    def find(id)
      @records[id.to_i - 1]
    end

    private

    def build_entity(params = {})
      tweet = TweetEntity.new
      tweet.attributes = params
      tweet
    end

  end
end