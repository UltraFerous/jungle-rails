class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, :presence => true, :confirmation => true, :length => {:within => 5..40}

  def self.authenticate_with_credentials(email, password)
    @email = email.gsub(/\s+/, "")
    @email_lower = @email.downcase
    @user = User.find_by_email(@email_lower)
    if(@user.authenticate(password))
      @user
    else
      nil
    end
  end

end
