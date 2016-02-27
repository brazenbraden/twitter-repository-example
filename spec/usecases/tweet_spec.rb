require_relative '../spec_helper'

describe Usecase::CreateTweet do

  context 'Policy::User::CanCreateTweet' do
    it 'should raise a PolicyException if the user does not have permission to create a tweet' do
      user = instance_double('User', permissions: { tweet: []})
      policy = Policy::User::CanCreateTweet.new(user)
      expect{policy.check}.to raise_error(PolicyException)
    end

    it 'should not raise a PolicyException if the user does have permissions to create a tweet' do
      user = instance_double('User', permissions: { tweet: [:can_create_tweet]})
      policy = Policy::User::CanCreateTweet.new(user)
      expect{policy.check}.not_to raise_exception
    end
  end

  context 'Repository::Memory::Tweet' do
    before :each do
      @repo = MemoryRepository::TweetRepository.new
    end

    it 'should return a tweet id' do
      tweet = @repo.create(tweet: 'First Tweet')
      expect(tweet.id).to eql(1)
    end

    it 'should store 2 tweets and return them' do
      tweet1 = @repo.create(tweet: 'This is my first tweet!')
      tweet2 = @repo.create(tweet: 'This is my second tweet!')
      expect(tweet1.tweet).to eql('This is my first tweet!')
      expect(tweet2.tweet).to eql('This is my second tweet!')
    end

    it 'should return all tweets when calling all' do
      @repo.create(tweet: 'This is my first tweet!')
      @repo.create(tweet: 'This is my second tweet!')
      expect(@repo.all.count).to eql(2)
    end

  end

  context 'Validator::TweetValidator' do
    before :each do
      @validator = Validator::TweetValidator.new
    end

    it 'should throw a Validation Exception if tweet is blank' do
      expect{@validator.valid?({tweet: ''})}.to raise_error(ValidationException)
    end

    it 'shhould throw a Validation Exception is tweet is over 180 characters long' do
      tweet = 'Bacon ipsum dolor amet frankfurter shankle tongue venison meatball, pork tail prosciutto pig beef ribs pancetta sirloin. Ball tip hamburger biltong, bacon alcatra capicola t-bone andouille fatback turkey. Meatloaf frankfurter turkey alcatra pig, cupim salami sausage pork flank turducken jerky boudin.'
      expect{@validator.valid?({tweet: tweet})}.to raise_error(ValidationException)
    end

    it 'should allow a normal tweet' do
      expect{@validator.valid?({tweet: 'This is a normal tweet'})}.not_to raise_error
    end
  end

  context 'Usecase::Tweet' do
    before :each do
      user = instance_double('User', name: 'Braden', permissions: { tweet: [:can_create_tweet]})
      policy = Policy::User::CanCreateTweet.new(user)
      repo = MemoryRepository::TweetRepository.new
      validator = Validator::TweetValidator.new
      @usecase = Usecase::CreateTweet.new(policy, repo, validator)
    end

    it 'should have a method execute which takes a hash of params' do
      expect{@usecase.execute({tweet: 'a tweet'})}.not_to raise_error
    end

    it 'should save the tweet' do
      tweet = @usecase.execute(tweet: 'Hello World!')
      expect(tweet.id).to eql(1)
      expect(tweet.tweet).to eql('Hello World!')
    end
  end


end