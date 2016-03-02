require_relative '../spec_helper'
require_relative '../comments_helper'

describe Usecase::CreateComment do
  it 'should create a comment entity' do
    entity = CommentEntity.new
    expect(entity).to be_an_instance_of(CommentEntity)
  end
end
