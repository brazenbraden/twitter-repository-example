class TweetEntity < BaseEntity
  attribute :id, Integer
  attribute :user_id, Integer
  attribute :tweet, String
  attribute :timestamp, Time
  attribute :comments, Hash
end