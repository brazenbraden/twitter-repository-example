require_relative '../spec_helper'
require_relative '../comments_helper'

describe Usecase::CreateComment do
  it 'should create a comment entity' do
    entity = CommentEntity.new
    expect(entity).to be_an_instance_of(CommentEntity)
  end

  context 'Validator::CommentValidator' do
    before :each do
      @validator = Validator::CommentValidator.new
    end

    it 'should validate the comment content' do
      comment = 'My first comment'
      expect{@validator.valid?(comment)}.not_to raise_error
    end

    it 'should fail for a blank comment' do
      expect{@validator.valid?('')}.to raise_error(ValidationException)
    end

    it 'should fail if comment is over 180 chars long' do
      comment = 'Bacon ipsum dolor amet frankfurter shankle tongue venison meatball, pork tail prosciutto pig beef ribs pancetta sirloin. Ball tip hamburger biltong, bacon alcatra capicola t-bone andouille fatback turkey. Meatloaf frankfurter turkey alcatra pig, cupim salami sausage pork flank turducken jerky boudin.'
      expect{@validator.valid?(comment)}.to raise_error(ValidationException)
    end
  end

  context 'Policy::User::CanCreateComment' do
    it 'should fail if user does not have permission to create a comment' do
      user = instance_double('User', permissions: { comment: []})
      policy = Policy::User::CanCreateComment.new(user)
      expect{policy.check}.to raise_error(PolicyException)
    end

    it 'should pass with valid user permissions' do
      user = instance_double('User', permissions: { comment: [:can_create_comment]})
      policy = Policy::User::CanCreateComment.new(user)
      expect{policy.check}.not_to raise_error
    end
  end

  it 'should save a comment to a tweet' do
    tweet = instance_double('Tweet', id: 1, tweet: 'Hello world!')
    comment = 'Welcome!'

  end
end
