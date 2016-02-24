require_relative '../spec_helper'

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

    it 'should expect the Tweet Memory repo' do
      tweet = Usecase::CreateTweet.new(nil, MemoryRepository::TweetRepository.new)
      expect(tweet.repo).to be_an_instance_of(MemoryRepository::TweetRepository)
    end
  end

  context 'Executing the usecase' do
    before :each do
      user = instance_double('User', name: 'Braden')
      policy = Policy::User::CanCreateTweet.new(user)
      repo = MemoryRepository::TweetRepository.new
      @usecase = Usecase::CreateTweet.new(policy, repo)
    end

    it 'should have a method execute which takes a hash of params' do
      expect{@usecase.execute({tweet: 'a tweet'})}.not_to raise_error
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
    before :each do
      user = instance_double('User', name: 'Braden')
      policy = Policy::User::CanCreateTweet.new(user)
      @repo = MemoryRepository::TweetRepository.new
      @usecase = Usecase::CreateTweet.new(policy, @repo)
    end

    it 'should return a tweet id' do
      tweet = @usecase.execute(tweet: 'First Tweet')
      expect(tweet.id).to eql(1)
    end

    it 'should store 2 tweets and return them' do
      @usecase.execute(tweet: 'This is my first tweet!')
      @usecase.execute(tweet: 'This is my second tweet!')
      tweet1 = @repo.find(1)
      tweet2 = @repo.find(2)
      expect(tweet1.tweet).to eql('This is my first tweet!')
      expect(tweet2.tweet).to eql('This is my second tweet!')
    end

    it 'should return all tweets when calling all' do
      @usecase.execute(tweet: 'This is my first tweet!')
      @usecase.execute(tweet: 'This is my second tweet!')
      expect(@repo.all.count).to eql(2)
    end

  end


end