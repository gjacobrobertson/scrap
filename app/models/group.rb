class Group < ActiveRecord::Base
  attr_accessible :name, :description

  has_and_belongs_to_many :users

  validates :name,  :presence => true,
                    :length => { :maximum => 50 }
  validates :description, :length => { :maximum => 500 }
end
