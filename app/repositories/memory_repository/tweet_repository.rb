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
      tweet = mapper(params)
      # Assumes we saving a new tweet.
      if tweet.id.blank?
        tweet.id = @id
        update_record(@id, tweet)
        @id += 1
        return tweet
      end
      update_record(tweet.id, tweet)
      tweet
    end

    def find(id)
      records[id.to_i]
    end

    # e.g.  repo.where(comment_id: 1)
    # return tweet
    def where(params)
      if params.has_key?(:comment_id)
        records.each do |key, tweet|
          tweet.comments.each do |comment|
            if comment.id == params[:comment_id].to_i
              return tweet
            end
          end
        end
      end
      # TODO: Raise a repository_exception as record wasnt found
      nil
    end

    private

    def update_record(id, tweet)
      records[id] = tweet
    end

    def mapper(params)
      if params.has_key?(:tweet_entity)
        return TweetEntity.new(params[:tweet_entity])
      end

      if params.has_key?(:comment_entity)
        tweet = find(params[:id])
        comment = CommentEntity.new(params[:comment_entity])
        comment.id = tweet.comments.count + 1
        comment.tweet_id = params[:id]
        tweet.comments << comment
        return tweet
      end

      if params.has_key?(:reply_entity)
        tweet = where(comment_id: params[:id])
        if tweet.blank?
          # TODO: throw repo exception
          return nil;
        end
        comment_index = nil
        comment = tweet.comments.each_with_index do |comment, i|
          if comment.id == params[:id].to_i
            comment_index = i
            comment
          end
        end.first

        if comment_index.blank?
          p "NO COMMENT FOUND"
          # TODO: raise repo validation
          return nil
        else
          reply = ReplyEntity.new(params[:reply_entity])
          reply.id = comment.replies.count + 1
          reply.comment_id = comment.id
          comment.replies << reply
          tweet.comments[comment_index] = comment
          return tweet
        end

      end
    end

    private
    attr_accessor :records

  end
end