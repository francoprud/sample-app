class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.mailer_default_sender
  layout 'mailer'
end
