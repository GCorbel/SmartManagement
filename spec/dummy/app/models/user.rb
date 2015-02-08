class User < ActiveRecord::Base
  belongs_to :company

  validates :name, :age, presence: true
end
