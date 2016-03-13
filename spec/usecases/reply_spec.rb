require_relative '../spec_helper'
require_relative '../tweet_helper'
require_relative '../comments_helper'
require_relative '../reply_helper.rb'

describe Usecase::CreateReply do

  context 'ReplyEntity' do
    it 'should return an Entity::ReplyEntity' do
      expect(ReplyEntity.new).to be_an_instance_of(ReplyEntity)
    end

    it 'should have an id, content' do
      entity = ReplyEntity.new(id: 1, content: 'a reply')
      expect(entity.id).to eql(1)
      expect(entity.content).to eql('a reply')
    end
  end

  context 'Policy::User::CanCreateReply' do
    it 'should be an instance of Policy::User::CanCreateReply' do
      expect(Policy::User::CanCreateReply.new({})).to be_an_instance_of(Policy::User::CanCreateReply)
    end

    it 'should fail is user has no permissions' do
      user = instance_double('User', permissions: { reply: []})
      expect{Policy::User::CanCreateReply.new(user).check}.to raise_error(PolicyException)
    end

    it 'should pass if user has permissions' do
      user = instance_double('User', permissions: { reply: [:can_create_reply]})
      expect{Policy::User::CanCreateReply.new(user).check}.not_to raise_error
    end
  end

  context 'Validator::ReplyValidator' do
    before :each do
      @validator = Validator::ReplyValidator.new
    end
    it 'should be an instance of Validator::ReplyValidator' do
      expect(@validator).to be_an_instance_of(Validator::ReplyValidator)
    end

    it 'should fail if reply content is empty' do
      expect{@validator.valid?({})}.to raise_error(ValidationException)
    end

    it 'should fail if reply is longer than 180 chars' do
      reply = {reply_entity: { content: 'Bacon ipsum dolor amet frankfurter shankle tongue venison meatball, pork tail prosciutto pig beef ribs pancetta sirloin. Ball tip hamburger biltong, bacon alcatra capicola t-bone andouille fatback turkey. Meatloaf frankfurter turkey alcatra pig, cupim salami sausage pork flank turducken jerky boudin.'}}
      expect{@validator.valid?(reply)}.to raise_exception(ValidationException)
    end

    it 'should pass if reply is well formed' do
      expect{@validator.valid?(content: 'a valid comment')}.not_to raise_error
    end
  end

  context 'Usecase::CreateReply' do
    before :each do
      # TODO: Need to mock this
      user = instance_double('User', permissions: {tweet: [:can_create_tweet], comment: [:can_create_comment], reply: [:can_create_reply] })
      repo = MemoryRepository::TweetRepository.new
      # Create the tweet
      Usecase::CreateTweet.new(
        Policy::User::CanCreateTweet.new(user),
        repo,
        Validator::TweetValidator.new
      ).execute(tweet_entity: {tweet: 'Hello World'})
      # Create comment
      Usecase::CreateComment.new(
        Policy::User::CanCreateComment.new(user),
        repo,
        Validator::CommentValidator.new
      ).execute({id: 1, comment_entity: {comment: 'foo bar'}})

      @usecase = Usecase::CreateReply.new(
        Policy::User::CanCreateReply.new(user),
        repo,
        Validator::ReplyValidator.new
      )
    end

    it 'should create a reply to a comment' do
      params = {id: 1, reply_entity: {content: 'sausage'}}
      tweet = @usecase.execute(params)
      expect(tweet.id).to eql(1)
      expect(tweet.comments.first.id).to eql(1)
      expect(tweet.comments.first.replies.first.id).to eql(1)
      expect(tweet.comments.first.replies.first.content).to eql('sausage')
    end

  end

end