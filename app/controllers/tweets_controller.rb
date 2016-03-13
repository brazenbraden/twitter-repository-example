class TweetsController < ApplicationController

  def index
    @tweets = repo.all
  end

  def show
    @resource = Decorator::Tweet.new(repo.find(params[:id]))
  end

  def create
    Usecase::CreateTweet.new(policy, repo, validator).execute(params)
    redirect_to tweets_path
  end

  private

  def repo
    Repository.for(:tweet)
  end

  def policy
    # TODO: Map current_user to UserEntity
    user = UserEntity.new
    user.name = 'Braden'
    user.permissions =  {tweet: [:can_create_tweet], comment: [:can_create_comment], reply: [:can_create_reply]}
    Policy::User::CanCreateTweet.new(user)
  end

  def validator
      Validator::TweetValidator.new
  end

end