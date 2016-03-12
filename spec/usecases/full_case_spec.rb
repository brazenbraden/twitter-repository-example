require_relative '../spec_helper'
require_relative '../tweet_helper'
require_relative '../comments_helper'
require_relative '../reply_helper'

describe 'Full System Test' do
  before :all do
    @repo = MemoryRepository::TweetRepository.new
  end

  before :each do
    @user = instance_double('User', permissions: {
      tweet: [:can_create_tweet],
      comment: [:can_create_comment],
      reply: [:can_create_reply]}
    )
  end

  it 'should create a Tweet' do
    policy = Policy::User::CanCreateTweet.new(@user)
    validator = Validator::TweetValidator.new
    params = { tweet_entity: {tweet: 'hello world'} }
    tweet = Usecase::CreateTweet.new(policy, @repo, validator).execute(params)
    expect(tweet.id).to eql(1)
    expect(tweet.tweet).to eql('hello world')
  end

  it 'should create a comment to the tweet' do
    policy = Policy::User::CanCreateComment.new(@user)
    validator = Validator::CommentValidator.new
    params = { id: 1, comment_entity: { comment: 'a comment' }}
    tweet = Usecase::CreateComment.new(policy, @repo, validator).execute(params)
    expect(tweet.comments.first.id).to eql(1)
    expect(tweet.comments.first.comment).to eql('a comment')
    expect(tweet.tweet).to eql('hello world')
  end

  it 'should create a reply to a comment' do
    policy = Policy::User::CanCreateReply.new(@user)
    validator = Validator::ReplyValidator.new
    params = { id: 1, comment_entity: { id: 1, reply_entity: { content: 'a reply' } }}
    tweet = Usecase::CreateReply.new(policy, @repo, validator).execute(params)
    expect(tweet.comments.first.replies.first.id).to eql(1)
    expect(tweet.comments.first.replies.first.content).to eql('a reply')
  end
end