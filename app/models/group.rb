class Group < ActiveRecord::Base
  attr_accessible :name, :description

  validates :name,  :presence => true,
                    :length => { :maximum => 50 }
  validates :description, :length => { :maximum => 500 }
end
