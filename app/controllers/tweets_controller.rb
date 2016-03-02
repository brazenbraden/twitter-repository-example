class TweetsController < ApplicationController

  def index
    @tweets = repo.all
    @tweet = TweetEntity.new
  end

  def show
    @tweet = repo.find(params[:id])
  end

  def create
    Usecase::CreateTweet.new(policy(:create), repo, validator).execute(permitted_params)
    redirect_to tweets_path
  end

  def delete

  end

  private

  def permitted_params
    params.require(:tweet_entity).permit(:tweet)
  end

  def repo
    Repository.for(:tweet)
  end

  def policy(key)
    user = UserEntity.new
    user.name = 'Braden'
    user.permissions =  {tweet: [:can_create_tweet]}
    {
      create: Policy::User::CanCreateTweet.new(user)
    }[key]
  end

  def validator
    Validator::TweetValidator.new
  end

end