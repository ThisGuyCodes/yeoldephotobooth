class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::SCrypt
    c.change_single_access_token_with_password = true
  end

  has_many :posts, dependent: :delete_all
end
