class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

  has_and_belongs_to_many :groups

  has_secure_password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,      :presence     => true,
                        :length       => { :maximum => 50 }
  validates :email,     :presence     => true,
                        :format       => { :with => email_regex },
                        :uniqueness   => { :case_sensitive => false }
  validates :password,  :presence     => true,
                        :on           => :create
end
