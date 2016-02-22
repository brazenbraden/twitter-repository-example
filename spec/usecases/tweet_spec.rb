require_relative '../spec_helper'
require_relative '../../app/usecases/usecase/create_tweet'
require_relative '../../app/policies/policy/user/can_create_tweet'
require_relative '../../app/repositories/memory_repository/tweet_repository'
require_relative '../../app/repositories/memory_repository/tweet'

describe Usecase::CreateTweet do

  context 'Initializing an instance' do
    it 'should return an instance of CreateTweet' do
      expect(Usecase::CreateTweet.new(nil, nil)).to be_an_instance_of(Usecase::CreateTweet)
    end

    it 'should expect a policy' do
      policy = {}
      tweet = Usecase::CreateTweet.new(policy, nil)
      expect(tweet.policy).to eql(policy)
    end

    it 'should expect a repo' do
      repo = ''
      tweet = Usecase::CreateTweet.new(nil, repo)
      expect(tweet.repo).to eql(repo)
    end

    it 'should expect the Tweet repo' do
      tweet = Usecase::CreateTweet.new(nil, MemoryRepository::TweetRepository.new)
      expect(tweet.repo).to be_an_instance_of(MemoryRepository::TweetRepository)
    end
  end

  context 'Executing the usecase' do
    before :each do
      @tweet = Usecase::CreateTweet.new(nil, MemoryRepository::TweetRepository.new)
    end

    it 'should have a method execute which takes a hash of params' do
      expect{@tweet.execute({tweet: 'a tweet'})}.not_to raise_error
    end
  end

  context 'the User::CanCreateTweet policy' do
    it 'is an instance of Policy::User::CanCreateTweet' do
      expect(Policy::User::CanCreateTweet.new({})).to be_an_instance_of(Policy::User::CanCreateTweet)
    end

    it 'takes a user argument' do
      user = {}
      expect{Policy::User::CanCreateTweet.new(user)}.not_to raise_error
    end

    it 'has a check method' do
      policy = Policy::User::CanCreateTweet.new({})
      expect{policy.check}.not_to raise_error
    end
  end

  context 'the Tweet Repository' do
    it 'should have a new method which accepts an hash' do
      repo = MemoryRepository::TweetRepository.new
      expect{repo.new}.not_to raise_error
    end

    it 'should return a tweet id' do
      tweet = Usecase::CreateTweet.new(nil, MemoryRepository::TweetRepository.new)
      result = tweet.execute('First Tweet')
      expect(result.id).to eql(1)
    end
  end


end