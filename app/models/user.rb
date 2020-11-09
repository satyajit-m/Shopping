class User < ApplicationRecord
  has_secure_password
  
  after_initialize :set_defaults, unless: :persisted?

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_NAME_REGEX = /\A[^0-9`!@#\$%\^&*+_=]+\z/.freeze

  validates_uniqueness_of :email, case_sensitive: false
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates_format_of :name, { with: VALID_NAME_REGEX }

  def set_defaults
    self.admin = false if self.admin.nil?
  end

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
