class Tweet < ActiveRecord::Base
  validates :tweet, null: false
end
