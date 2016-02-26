require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:relationship).valid?).to be true
  end

  context 'When creating an invalid relationship' do
    it 'validates followed_id non to be nil' do
      expect(FactoryGirl.build(:relationship, followed_id: nil).valid?).to be false
    end

    it 'validates follower_id non to be nil' do
      expect(FactoryGirl.build(:relationship, follower_id: nil).valid?).to be false
    end
  end
end
