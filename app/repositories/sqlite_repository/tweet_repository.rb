module SqliteRepository
  class TweetRepository

    def model_name
      ::Tweet
    end

    def all
      model_name.order(created_at: :desc)
    end

    def create(params = {})
      model_name.create(params)
    end

  end
end