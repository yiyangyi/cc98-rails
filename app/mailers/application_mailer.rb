class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  default charset: "utf-8"
  default content_type: "text/html"

  layout 'mailer'
end
