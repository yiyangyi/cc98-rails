class SendEmailsJob < ActiveJob::Base
  queue_as :default

  rescue_from() do |exception|
    # Do something with the exception
  end

  def perform(*args)
    # Do something later
  end
end
