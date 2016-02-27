module MemoryRepository
  class TweetRepository

    def initialize
      @records = {}
      @id = 1
    end

    def all
      records
    end

    def create(params = {})
      tweet = build_entity(params.merge(id: @id))
      records[@id.to_i] = tweet
      @id += 1
      tweet
    end

    def find(id)
      records[id.to_i]
    end

    private
    attr_accessor :records

    def build_entity(params = {})
      tweet = TweetEntity.new
      tweet.attributes = params
      tweet
    end

  end
end