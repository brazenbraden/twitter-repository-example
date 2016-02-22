module MemoryRepository
  class Tweet
    attr_accessor :id, :tweet

    def new(attributes)
      {
        id: attributes[:id],
        tweet: attributes[:tweet]
      }
    end
  end
end