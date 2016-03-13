class CommentsController < ApplicationController

  def new
  end

  def create
    Usecase::CreateComment.new(policy, repo, validator).execute(params)
    redirect_to tweet_path(params[:id])
  end

  private

  def policy
    # TODO: Map current_user to UserEntity
    user = UserEntity.new
    user.name = 'Braden'
    user.permissions =  {tweet: [:can_create_tweet], comment: [:can_create_comment], reply: [:can_create_reply]}
    Policy::User::CanCreateComment.new(user)
  end

  def repo
    Repository.for(:tweet)
  end

  def validator
    Validator::CommentValidator.new
  end

end