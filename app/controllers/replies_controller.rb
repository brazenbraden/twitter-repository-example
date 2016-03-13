class RepliesController < ApplicationController

  def new
  end

  def create
    tweet = Usecase::CreateReply.new(policy, repo, validator).execute(params)
    redirect_to tweet_path(tweet.id)
  end

  private

  def policy
    user = UserEntity.new
    user.name = 'Braden'
    user.permissions =  {tweet: [:can_create_tweet], comment: [:can_create_comment], reply: [:can_create_reply]}
    Policy::User::CanCreateReply.new(user)
  end

  def repo
    Repository.for(:tweet)
  end

  def validator
    Validator::ReplyValidator.new
  end
end