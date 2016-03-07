require_relative '../reply_helper.rb'
require_relative '../spec_helper'

describe Usecase::CreateReply do

  context 'ReplyEntity' do
    it 'should return an Entity::ReplyEntity' do
      expect(ReplyEntity.new).to be_an_instance_of(ReplyEntity)
    end

    it 'should have an id, content and timestamp' do
      time = Time.now
      entity = ReplyEntity.new(id: 1, content: 'a reply', timestamp: time)
      expect(entity.id).to eql(1)
      expect(entity.content).to eql('a reply')
      expect(entity.timestamp).to eql(time)
    end
  end

  context 'Policy::User::CanCreateReply' do
    it 'should be an instance of Policy::User::CanCreateReply' do
      expect(Policy::User::CanCreateReply.new({})).to be_an_instance_of(Policy::User::CanCreateReply)
    end

    it 'should fail is user has no permissions' do
      user = instance_double('User', permissions: { reply: []})
      expect{Policy::User::CanCreateReply.new(user).check}.to raise_error(PolicyException)
    end

    it 'should pass if user has permissions' do
      user = instance_double('User', permissions: { reply: [:can_create_reply]})
      expect{Policy::User::CanCreateReply.new(user).check}.not_to raise_error
    end
  end

  context 'Validator::ReplyValidator' do
    it 'should be an instance of Validator::ReplyValidator' do
      expect(Validator::ReplyValidator.new).to be_an_instance_of(Validator::ReplyValidator)
    end

    it 'should fail if reply content is empty' do
      expect{Validator::ReplyValidator.new.valid?('')}.to raise_error(ValidationException)
    end

    it 'should fail if reply is longer than 180 chars' do
      reply = 'Bacon ipsum dolor amet frankfurter shankle tongue venison meatball, pork tail prosciutto pig beef ribs pancetta sirloin. Ball tip hamburger biltong, bacon alcatra capicola t-bone andouille fatback turkey. Meatloaf frankfurter turkey alcatra pig, cupim salami sausage pork flank turducken jerky boudin.'
      expect{Validator::ReplyValidator.new.valid?(reply)}.to raise_exception(ValidationException)
    end

    it 'should pass if reply is well formed' do
      expect{Validator::ReplyValidator.new.valid?('a valid comment')}.not_to raise_error
    end
  end

  context 'Usecase::CreateReply' do
    it 'should be an instance of Usecase::CreateReply' do
      expect(Usecase::CreateReply.new()).to be_an_instance_of(Usecase::CreateReply)
    end


  end

end