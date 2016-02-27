class UserEntity < BaseEntity
  attribute :name, String
  attribute :permissions, Hash
end