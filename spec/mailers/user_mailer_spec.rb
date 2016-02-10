require 'rails_helper'

describe UserMailer do
  let!(:user) { FactoryGirl.create(:user) }

  describe 'account_activation' do
    let!(:mail) { described_class.account_activation(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq 'Account activation'
    end

    it 'renders the sender email' do
      expect(mail.from).to eq [Rails.application.secrets.mailer_default_sender]
    end

    it 'renders the reciever email' do
      expect(mail.to).to eq [user.email]
    end
  end
end
