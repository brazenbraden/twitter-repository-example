module MemoryRepository
  class TweetRepository

    def initialize
      @records = {}
      @id = 1
    end

    def model_class
      MemoryRepository::Tweet
    end

    def new(attributes = {})
      model_class.new(attributes)
    end

    def save(object)
      object.id = @id
      @records[@id] = object
      @id += 1
      return object
    end

    def find(id)
      @records[id.to_i]
    end

  end
end