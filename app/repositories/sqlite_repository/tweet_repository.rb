module SqliteRepository
  class TweetRepository

    def model_name
      ::Tweet
    end

    def all
      entities = []
      model_name.order(created_at: :desc).each do |item|
        entities << build_entity(item.attributes)
      end
    end

    def create(params = {})
      build_entity model_name.create(params).attributes
    end

    def find(id)
      build_entity model_name.find(id).attributes
    end

    private

    def build_entity(params)
      tweet = TweetEntity.new
      tweet.attributes = params
      tweet
    end

  end
end