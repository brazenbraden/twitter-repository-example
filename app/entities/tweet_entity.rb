class TweetEntity < BaseEntity
  attribute :id, Integer
  attribute :tweet, String
  attribute :timestamp, Time
end