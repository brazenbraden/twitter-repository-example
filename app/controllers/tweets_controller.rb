class TweetsController < ApplicationController

  def index
    @tweets = repo.all
  end

  def show

  end

  def new
    @tweet = TweetEntity.new
  end

  def create
  end

  def edit

  end

  def update

  end

  def delete

  end

  private

  def permitted_params
    params.require(:tweet).permit(:tweet)
  end

  def repo
    MemoryRepository::TweetRepository.new
  end

  def policy(key)
    {
      create: Policy::User::CanCreateTweet.new(nil)
    }[key]
  end

end