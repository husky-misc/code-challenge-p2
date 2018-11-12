class ApiKey
  include Mongoid::Document
  field :access_token, type: String
  
    def self.generate_access_token
        SecureRandom.hex
    end
  end