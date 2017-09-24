class ApplicationMailer < ActionMailer::Base
  default from: 'List of Demands No Reply <noreply@listofdemands.com>'
  layout 'mailer'
end
