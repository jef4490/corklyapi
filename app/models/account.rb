class Account < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true

  has_many :teams
  has_many :boards, through: :teams

  # validates :email, uniqueness: true
  def self.authenticate(identifier, password)
    username = Account.find_by(username: identifier)
    username.authenticate(password) if username
    email = Account.find_by(email: identifier)
    email.authenticate(password) if email
    (username && username.authenticate(password)) || (email && email.authenticate(password))
  end

end
