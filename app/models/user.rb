class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Scrypt
    c.change_single_access_token_with_password = true
  end
end
