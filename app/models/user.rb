class User < ActiveRecord::Base
  has_secure_password
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates_length_of :password, presence: true, :minimum => 4

  
  def self.authenticate_with_credentials(email, password)
    return nil if email == nil
    @user = User.find_by_email(email.downcase.strip)
    @user && @user.authenticate(password) ? @user : nil
  end
end