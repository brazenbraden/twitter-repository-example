class CommentEntity < BaseEntity
  attribute :id, Integer
  attribute :tweet_id, Integer
  attribute :user_id, Integer
  attribute :comment, String
  attribute :created_at, Time
  attribute :replies, Array
end