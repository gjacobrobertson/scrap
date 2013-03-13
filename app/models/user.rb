class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :rememberable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :remember_me, :provider, :uid, :name

  validates :name, :presence => true

  has_many :debits, :class_name => 'Transaction', :foreign_key => "to_id"
  has_many :credits, :class_name => 'Transaction', :foreign_key => "from_id"
  # attr_accessible :title, :body
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
         provider:auth.provider,
         uid:auth.uid,
         )
    end
    user
  end
end
