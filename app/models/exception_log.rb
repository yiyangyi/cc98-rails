class ExceptionLog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :body
end
