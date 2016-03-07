class CommentEntity < BaseEntity
  attribute :id, Integer
  attribute :user_id, Integer
  attribute :comment, String
  attribute :timestamp, Time
  attribute :replies, Array
end