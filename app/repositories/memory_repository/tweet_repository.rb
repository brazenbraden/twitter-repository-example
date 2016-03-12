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
      tweet = mapper(params).first
      tweet.id = @id
      records[@id] = tweet
      @id += 1
      tweet
    end

    def update(params = {})
      tweet = find(params[:id].to_i)
      entities = mapper(params)
      p entities
      entities.each do |entity|
        if entity.is_a?(CommentEntity)
          comment = entity
          comment.id = tweet.comments.count + 1
          tweet.comments << comment
        elsif entity.is_a?(ReplyEntity)
          comment_id = params[:comment_entity][:id]
          comment = tweet.comments[comment_id]
          reply.id = tweet.comments.replies.count + 1
          comment.replies << reply
          tweet.comments[comment_id] = comment
        end
      end
      records[tweet.id] = tweet
      tweet
    end

    def find(id)
      records[id.to_i]
    end

    # def mapper(params)
    #   p "params: #{params}"
    #   embedded = params.select {|k,v| k.to_s.include?('_entity')}
    #   p "embedded: #{embedded}"
    # end

    def mapper(params)
      p "params: #{params}"
      entities = []
      entities << params.select do |k, v|
        # p "key: #{k}"
        # p "value: #{v}"

        # if k.has_key?(:id)
        #   return
        # end

        if k.to_s.include?('_entity')
          mapper(v)
        else
          p "time to split the entity param"

          xxx
          # entity = k.split('_').collect { |str| str.capitalize }.join('')
          # entity.constantize.new(v)
          # entity
        end

      end
    end
      # entities = build_entities([], params)

      # p "Final Entities: #{entities}"
      # entities

      # params.each do |param|
      #   key = param[0].to_s
      #   values = param[1]
      #   p values
      #   if key.include?('_entity') && !values.include?('id')
      #     entity = key.split('_').collect { |str| str.capitalize }.join('')
      #     entities << entity.constantize.new(values)
      #   end
      # end
      # entities
    # end

    # def build_entities(entities, params)
    #     p "values: #{params}"
    #     params.select do |key, value|
    #       entities << build_entities(entities, value) if key.include?('_entity')
    #     end
    #     # if !params.include?('id')
    #     #   if params.include?('_entity')
    #     #     entity = key.split('_').collect { |str| str.capitalize }.join('')
    #     #     entities << entity.constantize.new(values)
    #     #     build_entities(entities, values)
    #     #   end
    #     # end
    #     entities
    # end

    private
    attr_accessor :records

    # def build_tweet_entity(params = {})
    #   tweet = TweetEntity.new(params)
    #   tweet
    # end

    # def build_comment_entity(params = {})
    #   comment = CommentEntity.new(params)
    #   comment
    # end
    #
    # def build_reply_entity(params = {})
    #   reply = ReplyEntity.new(params)
    #   reply
    # end

  end
end