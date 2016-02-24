class TweetEntity
  include ActiveModel::Model
  include Virtus.model

  attribute :id, Integer
  attribute :tweet, String

  validates :tweet, null: false #max length = 180

end