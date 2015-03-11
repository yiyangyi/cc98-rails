class Note
  include Mongoid::Document

  field :title
  field :body
  field :word_count, type: Integer
  field :changes_count, type: Integer, default: 0
  field :publish, type: Mongoid::Boolean, default: false

  belongs_to :user
end
