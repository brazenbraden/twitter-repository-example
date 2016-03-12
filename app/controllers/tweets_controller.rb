class TweetsController < ApplicationController

  def index
    @tweets = repo.all
    @tweet = TweetEntity.new
  end

  def show
    @view = Decorator::Tweet.new(repo.find(params[:id]))
  end

  def create
    Usecase::CreateTweet.new(policy(:create_tweet), repo, validator(:tweet)).execute(permitted_params)
    redirect_to tweets_path
  end

  def update
    entities = repo.mapper(params)
    xxx
    entities.each do |entity|
      if entity.type_of(CommentEntity)
        Usecase::CreateComment.new(policy(:create_comment), repo, validator(:comment)).execute(params[:id], entity)
      elsif entity.type_of(ReplyEntity)
        Usecase::CreateReply.new(policy(:create_reply), repo, validator(:reply)).execute(params[:id], entity)
      end
    end
    # comment = CommentEntity.new(params[:comment_entity])
    redirect_to tweet_path(params[:id])
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
    user.permissions =  {tweet: [:can_create_tweet], comment: [:can_create_comment], reply: [:can_create_reply]}
    {
      create_tweet: Policy::User::CanCreateTweet.new(user),
      create_comment: Policy::User::CanCreateComment.new(user),
      create_reply: Policy::User::CanCreateReply.new(user)
    }[key]
  end

  def validator(key)
    {
      tweet: Validator::TweetValidator.new,
      comment: Validator::CommentValidator.new,
      reply: Validator::ReplyValidator.new
    }[key]
  end

end