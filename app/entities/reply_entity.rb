class ReplyEntity < BaseEntity
  attribute :id, Integer
  attribute :comment_id, Integer
  attribute :content, String
  attribute :created_at, Time
end