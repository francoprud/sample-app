require 'rails_helper'

describe Micropost do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:micropost).valid?).to be true
  end

  context 'When creating an invalid micropost' do
    it 'validates the user_id not to be nil' do
      expect(FactoryGirl.build(:micropost, user: nil).valid?).to be false
    end

    it 'validates the content not to be nil' do
      expect(FactoryGirl.build(:micropost, content: nil).valid?).to be false
    end

    it 'validates the content not to be too long' do
      expect(FactoryGirl.build(:micropost, content: "#{'a' * 141}").valid?).to be false
    end
  end
end
