class Account < ApplicationRecord
  has_secure_password

  has_many :teams
  has_many :boards, through: :teams

  # validates :email, uniqueness: true
  def self.authenticate(username, password)
    account = Account.find_by(username: username)
    account && account.authenticate(password)
  end

end
