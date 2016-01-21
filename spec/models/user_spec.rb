require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user).valid?).to be true
  end

  context 'When creating an invalid user' do
    it 'validates the email not to be nil' do
      expect(FactoryGirl.build(:user, email: nil).valid?).to be false
    end

    it 'validates email no to be too long' do
      expect(FactoryGirl.build(:user, email: "#{'a' * 244}@example.com").valid?).to be false
    end

    it 'validates the email to have a vaild format' do
      invalid_addresses = %w(user@example,com user@example user user@example. user@example..com)
      invalid_addresses.each do |invalid_address|
        expect(FactoryGirl.build(:user, email: invalid_address).valid?).to be false
      end
    end

    it 'validates email uniqueness' do
      expect(FactoryGirl.create(:user).dup.valid?).to be false
    end

    it 'validates the email to be transformed into downcase before saving' do
      mixed_email = 'EXAMPLE@TEST.com'
      user = FactoryGirl.create(:user, email: mixed_email)
      expect(user.email).to eq mixed_email.downcase
    end

    it 'validates the name not to be nil' do
      expect(FactoryGirl.build(:user, name: nil).valid?).to be false
    end

    it 'validates name no to be too long' do
      expect(FactoryGirl.build(:user, name: 'a' * 51).valid?).to be false
    end

    it 'validates password not to be nil' do
      expect(FactoryGirl.build(:user, password: nil,
                                      password_confirmation: nil).valid?).to be false
    end

    it 'validates password to have minimum length' do
      invalid_password = "#{'a' * 5}"
      expect(FactoryGirl.build(:user, password: invalid_password,
                                      password_confirmation: invalid_password).valid?).to be false
    end
  end
end
