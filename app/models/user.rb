class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise(:database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable)

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :first_name, :last_name
  # attr_accessible :title, :body
  has_many :nodes
  has_many :projects
  has_many :tasks
  mount_uploader :avatar, AvatarUploader
  
  after_create :create_root
  def create_root
    self.projects.create(project_title: '/')
  end 
end

