class TweetEntity < BaseEntity
  attribute :id, Integer
  attribute :user_id, Integer
  attribute :tweet, String
  attribute :created_at, Time
  attribute :comments, Array
end