class Index < ActiveRecord::Base

  has_and_belongs_to_many :entries
end