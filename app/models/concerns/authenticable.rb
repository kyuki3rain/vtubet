module Authenticable
  INVALID_PASSWORD_REGEX = /\A([a-z]+|\d+)\z/i # アルファベットのみ、数字のみはNG

  extend ActiveSupport::Concern

  included do
    
    attr_accessor :activation_token, :remember_token, :reset_token

    before_save :downcase_email
    before_create :create_activation_digest

    validates :email, presence: true,
                      email: true,
                      uniqueness: { case_sensitive: false }
    validates :password, presence: true,
                         length: { minimum: 8 },
                         format: { without: INVALID_PASSWORD_REGEX, message: 'は英字・数字を両方を使ってください' },
                         allow_nil: true
  end

  module ClassMethods
    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def new_password
      pw = SecureRandom.urlsafe_base64
      # invalidなパスが生成された場合は再帰
      pw = new_password if INVALID_PASSWORD_REGEX.match?(pw)
      pw
    end
  end

  def remember
    self.remember_token = self.class.new_token
    update_attribute(:remember_digest, self.class.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def deactivate!
    return unless activated

    update!(activated: false, activated_at: nil)
  end

  def create_reset_digest
    self.reset_token = self.class.new_token
    update_attribute(:reset_digest,  self.class.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def password_reset_expired?
    reset_sent_at < 1.day.ago
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end