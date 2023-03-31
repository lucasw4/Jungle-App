class User < ApplicationRecord

  has_secure_password
  validates :email, uniqueness: { case_sensitive: false}, presence:true 
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, confirmation: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)

    @user = User.find_by_email(email.strip.downcase)

    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
end
