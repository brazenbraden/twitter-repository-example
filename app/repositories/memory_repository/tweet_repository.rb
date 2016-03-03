module MemoryRepository
  class TweetRepository

    def initialize
      @records = {}
      @id = 1
    end

    def all
      records.values
    end

    def create(params = {})
      tweet = build_tweet_entity(params.merge(id: @id))
      records[@id] = tweet
      @id += 1
      tweet
    end

    def update(tweet_id, params = {})
      tweet = find(tweet_id)
      comment = build_comment_entity(params)
      p comment
    end

    def find(id)
      records[id.to_i]
    end

    private
    attr_accessor :records

    def build_tweet_entity(params = {})
      tweet = TweetEntity.new(params)
      tweet.timestamp = Time.now
      tweet
    end

    def build_comment_entity(params = {})
      comment = CommentEntity.new(params)
      comment.timestamp = Time.now
      comment
    end

  end
end