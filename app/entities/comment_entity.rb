class CommentEntity < BaseEntity
  attribute :id, Integer
  attribute :comment, String
  attribute :timestamp, Time
end